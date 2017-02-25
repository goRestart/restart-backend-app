import ServiceLocator

// MARK: - User

extension Assembly {

    func getAddUser() -> AddUser {
        return AddUser(
            userService: getUserService()
        )
    }

    func getCheckIfUserNameIsAvailable() -> CheckIfUserNameIsAvailable {
        return CheckIfUserNameIsAvailable(
            userService: getUserService()
        )
    }

    func getCheckIfEmailIsAvailable() -> CheckIfEmailIsAvailable {
        return CheckIfEmailIsAvailable(
            userService: getUserService()
        )
    }
}

// MARK: - Auth

extension Assembly {

    func getAuthorizeUser() -> AuthorizeUser {
        return AuthorizeUser(
            authService: getAuthService()
        )
    }
}
