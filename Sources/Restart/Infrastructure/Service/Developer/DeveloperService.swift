import Foundation

public struct DeveloperService {

    private let checkIfApiKeyIsValidTask: CheckIfApiKeyIsValidTask

    init(checkIfApiKeyIsValidTask: CheckIfApiKeyIsValidTask) {
        self.checkIfApiKeyIsValidTask = checkIfApiKeyIsValidTask
    }

    func isApiKeyValid(privateKey: String, publicKey: String) throws {
        return try checkIfApiKeyIsValidTask.execute(privateKey, publicKey)
    }
}
