import ServiceLocator

extension Assembly {

    func getUserService() -> UserService {
        return UserService(
            verifyFieldTask: getVerifyFieldTask(),
            addUserTask: getAddUserTask()
        )
    }
}
