import Foundation
import Domain
import Cache

private struct Keys {
    static let session = "session"
}

protocol SessionDataSourceProvider {
    func inMemory() -> SessionDataSource
}

public struct InMemorySessionDataSource: SessionDataSource {

    private let memoryCache: CacheProtocol

    init(memoryCache: CacheProtocol) {
        self.memoryCache = memoryCache
    }

    @discardableResult
    func store(_ request: AddSessionRequest) throws -> UserSession {
        let token = UUID().uuidString
        let key = "\(Keys.session)_\(request.userId)_\(token)"
        let validUntil = Date().addingTimeInterval(request.validityInterval)

        try memoryCache.set(key, token, expiration: validUntil)
        
        return UserSession(
            token: token,
            validUntil: Date().addingTimeInterval(request.validityInterval)
        )
    }
}
