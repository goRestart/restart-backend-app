import ServiceLocator

extension Assembly {

    func getSuggestionController() -> SuggestionController {
        return SuggestionController(
            getSuggestionsWithQuery: getSuggestionsWithQuery(),
            addSuggestion: getAddSuggestion()
        )
    }
}

