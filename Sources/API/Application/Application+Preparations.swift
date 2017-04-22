import Vapor
import ServiceLocator
import RedisProvider
import MySQLProvider
import Storage

extension Application {

    func prepare(_ droplet: Droplet) throws {
        
        try prepareProviders(for: droplet)
        
        let apiAuthMiddleware = Dependency().getApiAuthMiddleware()

        droplet.addConfigurable(
            middleware: apiAuthMiddleware,
            name: String(describing: "api-auth")
        )
        
        FluentStorage.initialize(droplet)
    }
    
    // MARK: - Providers 
    
    private func prepareProviders(`for` droplet: Droplet) throws {
        try droplet.addProvider(RedisProvider.Provider)
        try droplet.addProvider(MySQLProvider.Provider)
    }
}
