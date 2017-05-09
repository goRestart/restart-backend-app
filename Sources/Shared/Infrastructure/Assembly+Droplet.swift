import ServiceLocator
import Vapor

public extension Assembly {
    
    public func getDroplet() -> Droplet {
        let key = String(describing: Droplet.self)
        guard let droplet: Droplet = Resolve(key) else {
            let service: Droplet = try! Droplet(
                config: try getConfigProvider().config()
            )
            return Register(service, key: key)
        }
        return droplet
    }
    
    private func getConfigProvider() -> ConfigProvider {
        return ApplicationConfig()
    }
}
