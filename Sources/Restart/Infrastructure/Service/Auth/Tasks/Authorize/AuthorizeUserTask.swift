import Foundation

public struct AuthorizeUserTask {

    private let passwordHasher: PasswordHasher

    init(passwordHasher: PasswordHasher) {
        self.passwordHasher = passwordHasher
    }

    func execute(_ request: AuthorizeUserRequest) throws {
        let hashedPassword = passwordHasher.hash(
            userName: request.userName,
            password: request.password
        )

        guard let user = try UserDiskModel.query()
            .filter(UserDiskModel.Field.username, request.userName)
            .filter(UserDiskModel.Field.password, hashedPassword)
            .first() else {
                throw AuthorizationError.invalidCredentials
        }

        let userNameIsEnabled = user.userStatus
        if !userNameIsEnabled {
            throw AuthorizationError.disabledUser
        }

        // TODO: Generate session data
    }
}
