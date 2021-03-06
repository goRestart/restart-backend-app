import ServiceLocator
import Restart

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
    
    func getGameController() -> GameController {
        return GameController(
            getPlatForms: getPlatforms()
        )
    }
}
