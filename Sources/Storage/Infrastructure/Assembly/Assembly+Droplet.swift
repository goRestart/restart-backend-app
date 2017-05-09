import ServiceLocator
import Vapor
import Cache
import RedisProvider
import Shared

public extension Assembly {
    
    func getMemoryCache() -> CacheProtocol {
        return getDroplet().cache
    }
}
