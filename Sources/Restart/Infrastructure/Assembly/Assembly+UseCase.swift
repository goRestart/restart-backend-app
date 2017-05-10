import ServiceLocator
import Storage

// MARK: - User

extension Assembly {

    public func getAddUser() -> AddUser {
        return AddUser(
            userService: getUserService()
        )
    }
}

// MARK: - Auth

extension Assembly {

    public func getAuthorizeUser() -> AuthorizeUser {
        return AuthorizeUser(
            authService: getAuthService()
        )
    }
}

// MARK: - Game

extension Assembly {
    
    public func getPlatforms() -> GetPlatforms {
        return GetPlatforms(
            gameRepository: getGameRepository()
        )
    }
}
