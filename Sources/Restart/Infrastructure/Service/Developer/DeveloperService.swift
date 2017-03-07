import Foundation

public struct DeveloperService {

    private let checkIfApiKeyIsValidTask: CheckIfApiKeyIsValidTask
    private let getPrivateKeyTask: GetPrivateKeyTask

    init(checkIfApiKeyIsValidTask: CheckIfApiKeyIsValidTask,
         getPrivateKeyTask: GetPrivateKeyTask)
    {
        self.checkIfApiKeyIsValidTask = checkIfApiKeyIsValidTask
        self.getPrivateKeyTask = getPrivateKeyTask
    }

    func isApiKeyValid(privateKey: String, publicKey: String) throws {
        return try checkIfApiKeyIsValidTask.execute(privateKey, publicKey)
    }

    func getPrivateKey(with publicKey: String) throws -> String {
        return try getPrivateKeyTask.execute(publicKey)
    }
}
