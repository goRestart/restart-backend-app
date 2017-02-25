import Foundation

public struct AuthorizeUserTask {

    private let passwordHasher: PasswordHasher

    init(passwordHasher: PasswordHasher) {
        self.passwordHasher = passwordHasher
    }

    func execute(_ request: AuthorizeUserRequest) throws {
        let userName = request.userName.lowercased()
        let password = request.password.lowercased()

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

        // TODO: Generate session data
    }
}
