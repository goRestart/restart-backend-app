import Foundation
import Storage
import Domain

public struct DeveloperService {

    private let checkIfApiKeyIsValidTask: CheckIfApiKeyIsValidTask
    private let getPrivateKeyTask: GetPrivateKeyTask

    init(checkIfApiKeyIsValidTask: CheckIfApiKeyIsValidTask,
         getPrivateKeyTask: GetPrivateKeyTask)
    {
        self.checkIfApiKeyIsValidTask = checkIfApiKeyIsValidTask
        self.getPrivateKeyTask = getPrivateKeyTask
    }

    public func isApiKeyValid(privateKey: String, publicKey: String) throws {
        return try checkIfApiKeyIsValidTask.execute(privateKey, publicKey)
    }

    public func getPrivateKey(with publicKey: String) throws -> String {
        return try getPrivateKeyTask.execute(publicKey)
    }
}
