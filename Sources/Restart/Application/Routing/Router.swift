import Vapor

public struct Router {

    private let droplet: Droplet
    private let suggestionRouteCollection: SuggestionRouteCollection

    public init(droplet: Droplet,
         suggestionRouteCollection: SuggestionRouteCollection)
    {
        self.droplet = droplet
        self.suggestionRouteCollection = suggestionRouteCollection
    }

    func route() {
        droplet.collection(suggestionRouteCollection)
    }
}
