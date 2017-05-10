import Vapor

public struct Router {

    private let droplet: Droplet
    private let userRouteCollection: UserRouteCollection
    private let authRouteCollection: AuthRouteCollection
    private let gameRouteCollection: GameRouteCollection

    public init(droplet: Droplet,
         userRouteCollection: UserRouteCollection,
         authRouteCollection: AuthRouteCollection,
         gameRouteCollection: GameRouteCollection)
    {
        self.droplet = droplet
        self.userRouteCollection = userRouteCollection
        self.authRouteCollection = authRouteCollection
        self.gameRouteCollection = gameRouteCollection
    }

    func route() {
        userRouteCollection.build(droplet)
        authRouteCollection.build(droplet)
        gameRouteCollection.build(droplet)
    }
}
