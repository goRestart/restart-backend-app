import ServiceLocator

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
