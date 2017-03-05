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
        let userName = request.userName.lowercased()
        let password = request.password

        let hashedPassword = passwordHasher.hash(
            userName: userName,
            password: password
        )

        guard let user = try UserDiskModel.query()
            .filter(UserDiskModel.Field.username, userName)
            .filter(UserDiskModel.Field.password, hashedPassword)
            .first() else {
                throw AuthorizationError.invalidCredentials
        }

        let userNameIsEnabled = user.userStatus
        if !userNameIsEnabled {
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
