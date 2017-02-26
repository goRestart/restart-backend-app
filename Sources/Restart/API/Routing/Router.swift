import Vapor

public struct Router {

    private let droplet: Droplet
    private let userRouteCollection: UserRouteCollection
    private let authRouteCollection: AuthRouteCollection

    public init(droplet: Droplet,
         userRouteCollection: UserRouteCollection,
         authRouteCollection: AuthRouteCollection)
    {
        self.droplet = droplet
        self.userRouteCollection = userRouteCollection
        self.authRouteCollection = authRouteCollection
    }

    func route() {
        droplet.collection(userRouteCollection)
        droplet.collection(authRouteCollection)
    }
}
