import ServiceLocator

// MARK: - User

extension Assembly {

    func getAddUser() -> AddUser {
        return AddUser(
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
