import Foundation

private let oneDay = 60 * 60 * 24
private let numberOfDaysInYear = 365
private let onYear = numberOfDaysInYear * oneDay
private let sessionAuthorizationInterval = TimeInterval(onYear * 2)

public struct AuthorizeUserTask {

    private let passwordHasher: PasswordHasher
    private let sessionRepository: SessionRepositoryProtocol

    init(passwordHasher: PasswordHasher,
         sessionRepository: SessionRepositoryProtocol)
    {
        self.passwordHasher = passwordHasher
        self.sessionRepository = sessionRepository
    }

    @discardableResult
    func execute(_ request: AuthorizeUserRequest) throws -> UserSession {
        let username = request.userName
        let password = request.password

        let hashedPassword = passwordHasher.hash(
            userName: username,
            password: password
        )

        guard let user = try UserDiskModel.query()
            .filter(UserDiskModel.Field.username, username)
            .filter(UserDiskModel.Field.password, hashedPassword)
            .first() else {
                throw AuthorizationError.invalidCredentials
        }
        

        let usernameIsEnabled = user.status() == .enabled
        if !usernameIsEnabled {
            throw AuthorizationError.disabledUser
        }

        let sessionRequest = AddSessionRequest(
            userId: user.id!.string!,
            validityInterval: sessionAuthorizationInterval
        )

        do {
            return try sessionRepository.store(sessionRequest)
        } catch {
            throw AuthorizationError.unknown
        }
    }
}
