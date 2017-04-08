import ServiceLocator

extension Assembly {

    func getUserController() -> UserController {
        return UserController(
            addUser: getAddUser()
        )
    }

    func getAuthController() -> AuthController {
        return AuthController(
            authorizeUser: getAuthorizeUser()
        )
    }
}
