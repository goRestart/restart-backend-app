import Vapor

public struct Application {

    private let droplet: Droplet
    private let router: Router

    public init(droplet: Droplet,
         router: Router)
    {
        self.droplet = droplet
        self.router = router
    }

    public func run() throws {
        try prepare(droplet)
        router.route()
        try droplet.run()
    }
}
