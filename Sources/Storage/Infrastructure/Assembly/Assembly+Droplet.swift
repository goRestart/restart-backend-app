import ServiceLocator
import Vapor

public extension Assembly {
    
    func getDroplet() -> Droplet {
        let key = String(describing: Droplet.self)
        guard let droplet: Droplet = Resolve(key) else {
            let service: Droplet = try! Droplet()
            return Register(service, key: key)
        }
        return droplet
    }
}
