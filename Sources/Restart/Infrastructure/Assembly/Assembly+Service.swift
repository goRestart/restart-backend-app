import ServiceLocator

extension Assembly {

    func getUserService() -> UserService {
        return UserService(
            addUserTask: getAddUserTask()
        )
    }
}
