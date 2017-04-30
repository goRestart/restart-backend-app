import Foundation
import Domain

private let oneDay = 60 * 60 * 24
private let numberOfDaysInYear = 365
private let onYear = numberOfDaysInYear * oneDay
private let sessionAuthorizationInterval = TimeInterval(onYear * 2)

public struct AuthorizeUserTask {

    private let passwordHasher: PasswordHasher
    private let userSessionRepository: UserSessionRepositoryProtocol

    init(passwordHasher: PasswordHasher,
         userSessionRepository: UserSessionRepositoryProtocol)
    {
        self.passwordHasher = passwordHasher
        self.userSessionRepository = userSessionRepository
    }

    @discardableResult
    public func execute(_ request: AuthorizeUserRequest) throws -> UserSession {
        let username = request.userName
        let password = request.password

        guard let user = try UserDiskModel.makeQuery()
            .filter(raw: "\(UserDiskModel.Field.username) = ('\(username)')")
            .first() else {
                throw AuthorizationError.invalidCredentials
        }
        
        guard let passwordHash = try user.password()?.hash,
              let passwordSalt = try user.password()?.salt else {
            throw AuthorizationError.invalidCredentials
        }

        let signature = passwordHasher.signature(
            username: username,
            password: password,
            salt: passwordSalt
        )
        
        let passwordMatches = try passwordHasher.check(input: signature, matches: passwordHash)
        if !passwordMatches {
            throw AuthorizationError.invalidCredentials
        }
        
        let usernameIsEnabled = user.status == .enabled
        if !usernameIsEnabled {
            throw AuthorizationError.disabledUser
        }

        let sessionRequest = AddSessionRequest(
            userId: user.id!.string!,
            validityInterval: sessionAuthorizationInterval
        )

        do {
            return try userSessionRepository.store(sessionRequest)
        } catch {
            throw AuthorizationError.unknown
        }
    }
}
