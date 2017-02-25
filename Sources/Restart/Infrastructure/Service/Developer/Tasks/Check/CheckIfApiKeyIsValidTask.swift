import Foundation

public struct CheckIfApiKeyIsValidTask {

    func execute(_ privateKey: String, _ publicKey: String) throws {
        guard let _ = try ApiKeyDiskModel.query()
            .filter(ApiKeyDiskModel.Field.privateKey, privateKey)
            .filter(ApiKeyDiskModel.Field.publicKey, publicKey)
            .first() else {
                throw ApiKeyError.invalidApiKeys
        }
    }
}
