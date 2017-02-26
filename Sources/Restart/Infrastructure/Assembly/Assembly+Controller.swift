import ServiceLocator

extension Assembly {

    func getUserController() -> UserController {
        return UserController(
            checkIfUserNameIsAvailable: getCheckIfUserNameIsAvailable(),
            checkIfEmailIsAvailable: getCheckIfEmailIsAvailable(),
            addUser: getAddUser()
        )
    }

    func getAuthController() -> AuthController {
        return AuthController(
            authorizeUser: getAuthorizeUser()
        )
    }
}

