import ServiceLocator

extension Assembly {

    func getRouter() -> Router {
        return Router(
            droplet: getDroplet(),
            userRouteCollection: getUserRouteCollection(),
            authRouteCollection: getAuthRouteCollection(),
            gameRouteCollection: getGameRouteCollection()
        )
    }

    func getUserRouteCollection() -> UserRouteCollection {
        return UserRouteCollection(
            userController: getUserController()
        )
    }

    func getAuthRouteCollection() -> AuthRouteCollection {
        return AuthRouteCollection(
            apiAuthMiddleware: getApiAuthMiddleware(),
            authController: getAuthController()
        )
    }
    
    func getGameRouteCollection() -> GameRouteCollection {
        return GameRouteCollection(
            gameController: getGameController()
        )
    }
}
