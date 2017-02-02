import Vapor

struct Router {

    private let droplet: Droplet
    private let suggestionRouteCollection: SuggestionRouteCollection

    init(droplet: Droplet,
         suggestionRouteCollection: SuggestionRouteCollection)
    {
        self.droplet = droplet
        self.suggestionRouteCollection = suggestionRouteCollection
    }

    func route() {
        droplet.collection(suggestionRouteCollection)
    }
}
