import ServiceLocator
import Vapor

// MARK: - Api auth

extension ApiAuthMiddleware: ConfigInitializable {
    
    public init(config: Config) throws {
        self.init(
            developerService: Dependency().getDeveloperService(),
            hasher: try config.resolveHash()
        )
    }
}

extension Assembly {

    func getApiAuthMiddleware() -> ApiAuthMiddleware {
        let droplet = getDroplet()
        return ApiAuthMiddleware(
            developerService: getDeveloperService(),
            hasher: droplet.hash
        )
    }
}
