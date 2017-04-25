import Foundation
import Vapor
import RedisProvider
import MySQLProvider
import Storage

struct ApplicationConfig: ConfigProvider {
    
    func config() throws -> Config {
        let config = try Config()
        try prepare(config)
        return config
    }
    
    private func prepare(_ config: Config) throws {
        try prepareMiddlewares(config)
        try prepareProviders(config)
        try prepareStorage(config)
    }
    
    // MARK: - Storage 
    
    private func prepareStorage(_ config: Config) throws {
        config.preparations += FluentStorage.preparations
    }
    
    // MARK: - Middleware

    private func prepareMiddlewares(_ config: Config) throws {
        config.addConfigurable(middleware: ApiAuthMiddleware.init, name: "api-auth")
    }
    
    // MARK: - Providers
    
    private func prepareProviders(_ config: Config) throws {
        try config.addProvider(RedisProvider.Provider)
        try config.addProvider(MySQLProvider.Provider)
    }
}
