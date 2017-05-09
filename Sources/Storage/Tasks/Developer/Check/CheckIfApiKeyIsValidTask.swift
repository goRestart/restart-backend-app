import Foundation
import Domain
import FluentStorage

public struct CheckIfApiKeyIsValidTask {

    public func execute(_ privateKey: String, _ publicKey: String) throws {
        guard let _ = try ApiKeyDiskModel.makeQuery()
            .filter(ApiKeyDiskModel.Field.privateKey, privateKey)
            .filter(ApiKeyDiskModel.Field.publicKey, publicKey)
            .first() else {
                throw ApiKeyError.invalidApiKeys
        }
    }
}
