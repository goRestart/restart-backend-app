import Foundation
import Cache
import Node

final class SessionCacheSpy: CacheProtocol {

    var getToReturn: Node?
    var setExecuted = false
    var setKey: String?
    var setKeyValue: Node?
    var deleteExecuted = false
    var deleteKey: String?

    func get(_ key: String) throws -> Node? {
        return getToReturn
    }

    func set(_ key: String, _ value: Node) throws {
        setExecuted = true
        setKey = key
        setKeyValue = value
    }

    func delete(_ key: String) throws {
        deleteExecuted = true
        deleteKey = key
    }
}
