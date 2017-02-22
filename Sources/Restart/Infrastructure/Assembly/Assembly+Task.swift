import ServiceLocator

extension Assembly {

    func getAddUserTask() -> AddUserTask {
        return AddUserTask(
            emailValidator: getEmailValidator(),
            passwordHasher: getPasswordHasher()
        )
    }
}
