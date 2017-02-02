import ServiceLocator
import Restart

extension Assembly {

    func getRouter() -> Router {
        return Router(
            droplet: getDroplet(),
            suggestionRouteCollection: getSuggestionRouteCollection()
        )
    }

    func getSuggestionRouteCollection() -> SuggestionRouteCollection {
        return SuggestionRouteCollection(
            suggestionController: getSuggestionController()
        )
    }
}

