import Foundation

struct GetPrivateKeyTask {

    func execute(_ publicKey: String) throws -> String {
        guard let apiKey = try ApiKeyDiskModel.query()
            .filter(ApiKeyDiskModel.Field.publicKey, publicKey)
            .first() else {
                throw ApiKeyError.invalidApiKeys
        }
        return apiKey.privateKey
    }
}
