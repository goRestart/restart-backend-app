import ServiceLocator

extension Assembly {

    func getSuggestionController() -> SuggestionController {
        return SuggestionController()
    }

    func getUserController() -> UserController {
        return UserController(
            checkIfUserNameIsAvailable: getCheckIfUserNameIsAvailable(),
            checkIfEmailIsAvailable: getCheckIfEmailIsAvailable(),
            addUser: getAddUser()
        )
    }
}

