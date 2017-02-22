import ServiceLocator

// MARK: - Suggestion 

extension Assembly {

    func getAddSuggestion() -> AddSuggestion {
        return AddSuggestion(
            suggestionRepository: getSuggestionRepository()
        )
    }

    func getSuggestionsWithQuery() -> GetSuggestionsWithQuery {
        return GetSuggestionsWithQuery(
            suggestionRepository: getSuggestionRepository()
        )
    }
}

// MARK: - User

extension Assembly {

    func getAddUser() -> AddUser {
        return AddUser(
            userService: getUserService()
        )
    }
}
