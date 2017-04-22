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

        let hashedPassword = try passwordHasher.hash(
            userName: username,
            password: password
        )

        guard let user = try UserDiskModel.makeQuery()
            .filter(UserDiskModel.Field.username, username)
            .filter(UserDiskModel.Field.password, hashedPassword)
            .first() else {
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
