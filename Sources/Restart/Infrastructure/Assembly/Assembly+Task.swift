import ServiceLocator

// MARK: - User

extension Assembly {

    func getAddUserTask() -> AddUserTask {
        return AddUserTask(
            emailValidator: getEmailValidator(),
            verifyFieldTask: getVerifyFieldTask(),
            passwordHasher: getPasswordHasher()
        )
    }

    func getVerifyFieldTask() -> VerifyFieldTask {
        return VerifyFieldTask()
    }
}

// MARK: - Auth

extension Assembly {

    func getAuthorizeUserTask() -> AuthorizeUserTask {
        return AuthorizeUserTask(
            passwordHasher: getPasswordHasher(),
            sessionRepository: getUserSessionRepository()
        )
    }
}
