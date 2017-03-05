import Foundation
import Cache

private struct Keys {
    static let token = "token"
}

public struct InMemorySessionDataSource: SessionDataSource {

    private let memoryCache: CacheProtocol

    init(memoryCache: CacheProtocol) {
        self.memoryCache = memoryCache
    }

    func store(_ request: AddSessionRequest) throws -> UserSession {
        let token = Identifier.make().value
        try memoryCache.set(Keys.token, token)

        return UserSession(
            token: token,
            validUntil: Date().addingTimeInterval(request.validityInterval)
        )
    }
}
