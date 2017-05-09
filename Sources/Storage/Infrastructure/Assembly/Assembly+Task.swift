import ServiceLocator
import Shared

// MARK: - User

public extension Assembly {

    public func getAddUserTask() -> AddUserTask {
        return AddUserTask(
            emailValidator: getEmailValidator(),
            verifyFieldTask: getVerifyFieldTask()
        )
    }

    public func getVerifyFieldTask() -> VerifyFieldTask {
        return VerifyFieldTask()
    }
}

// MARK: - Auth

public extension Assembly {

    public func getAuthorizeUserTask() -> AuthorizeUserTask {
        return AuthorizeUserTask(
            userSessionRepository: getUserSessionRepository()
        )
    }
}

// MARK: - Api Auth

public extension Assembly {

    public func getCheckIfApiKeyIsValidTask() -> CheckIfApiKeyIsValidTask {
        return CheckIfApiKeyIsValidTask()
    }

    public func getGetPrivateKeyTask() -> GetPrivateKeyTask {
        return GetPrivateKeyTask()
    }
}
