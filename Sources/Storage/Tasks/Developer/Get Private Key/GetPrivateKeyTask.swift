import Foundation
import Domain
import FluentStorage

public struct GetPrivateKeyTask {

    public func execute(_ publicKey: String) throws -> String {
        guard let apiKey = try ApiKeyDiskModel.makeQuery()
            .filter(ApiKeyDiskModel.Field.publicKey, publicKey)
            .filter(ApiKeyDiskModel.Field.enabled, true)
            .first() else {
                throw ApiKeyError.invalidApiKeys
        }
        return apiKey.privateKey
    }
}
