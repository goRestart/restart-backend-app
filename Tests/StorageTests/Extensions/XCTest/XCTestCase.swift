import XCTest
import Cache
import Vapor

public extension XCTestCase {
    
    public func getDroplet() throws -> Droplet {
        let config = try Config()
        config.addConfigurable(cache: MemoryCache.init, name: "redis")
        return try Droplet(config: config)
    }
}
