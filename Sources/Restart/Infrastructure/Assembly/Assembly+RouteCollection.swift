import ServiceLocator

extension Assembly {

    func getRouter() -> Router {
        return Router(
            droplet: getDroplet(),
            suggestionRouteCollection: getSuggestionRouteCollection(),
            userRouteCollection: getUSerRouteCollection()
        )
    }

    func getSuggestionRouteCollection() -> SuggestionRouteCollection {
        return SuggestionRouteCollection(
            suggestionController: getSuggestionController()
        )
    }

    func getUSerRouteCollection() -> UserRouteCollection {
        return UserRouteCollection(
            userController: getUserController()
        )
    }
}

