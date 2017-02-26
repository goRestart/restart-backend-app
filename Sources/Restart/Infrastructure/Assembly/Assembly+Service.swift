import ServiceLocator

extension Assembly {

    func getUserService() -> UserService {
        return UserService(
            verifyFieldTask: getVerifyFieldTask(),
            addUserTask: getAddUserTask()
        )
    }

    func getAuthService() -> AuthService {
        return AuthService(
            authorizeUserTask: getAuthorizeUserTask()
        )
    }
}
