import Foundation
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
        let token = Identifier.make().value
        let key = "\(Keys.session)_\(request.userId)_\(token)"
        try memoryCache.set(key, token)

        return UserSession(
            token: token,
            validUntil: Date().addingTimeInterval(request.validityInterval)
        )
    }
}
