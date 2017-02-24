import Vapor

public struct Router {

    private let droplet: Droplet
    private let suggestionRouteCollection: SuggestionRouteCollection
    private let userRouteCollection: UserRouteCollection

    public init(droplet: Droplet,
         suggestionRouteCollection: SuggestionRouteCollection,
         userRouteCollection: UserRouteCollection)
    {
        self.droplet = droplet
        self.suggestionRouteCollection = suggestionRouteCollection
        self.userRouteCollection = userRouteCollection
    }

    func route() {
        droplet.collection(suggestionRouteCollection)
        droplet.collection(userRouteCollection)
    }
}
