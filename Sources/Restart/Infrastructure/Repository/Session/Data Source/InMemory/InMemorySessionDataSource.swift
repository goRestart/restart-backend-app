import Foundation
import Cache

private struct Keys {
    static let token = "token"
}

public struct InMemorySessionDataSource: SessionDataSource {

    private let redisCache: CacheProtocol

    init(redisCache: CacheProtocol) {
        self.redisCache = redisCache
    }

    func store(_ request: AddSessionRequest) throws -> UserSession {
        let token = Identifier.make().value
        try redisCache.set(Keys.token, token)

        return UserSession(
            token: token,
            validUntil: Date().addingTimeInterval(request.validityInterval)
        )
    }
}
