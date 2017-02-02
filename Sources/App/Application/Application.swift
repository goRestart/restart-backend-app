import Foundation
import Vapor
import Fluent
import Restart

struct Application {

    private let droplet: Droplet
    private let router: Router

    init(droplet: Droplet,
         router: Router)
    {
        self.droplet = droplet
        self.router = router
    }

    func run() {
        prepare(droplet)
        router.route()
        droplet.run()
    }
}
