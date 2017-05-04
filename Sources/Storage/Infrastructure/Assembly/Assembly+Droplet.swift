import ServiceLocator
import Vapor
import Cache
import RedisProvider
import API

public extension Assembly {
    
    func getMemoryCache() -> CacheProtocol {
        return getDroplet().cache
    }
    
    func getHasher() -> HashProtocol {
        return CryptoHasher(
            hash: .sha256,
            encoding: .hex
        )
    }
}
