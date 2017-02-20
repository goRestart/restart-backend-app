import Foundation
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

    public func run() {
        prepare(droplet)
        router.route()
        droplet.run()
    }
}