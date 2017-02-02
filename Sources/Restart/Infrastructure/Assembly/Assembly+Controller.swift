import ServiceLocator
import Restart

extension Assembly {

    func getSuggestionController() -> SuggestionController {
        return SuggestionController(
            getSuggestionsWithQuery: getSuggestionsWithQuery(),
            addSuggestion: getAddSuggestion()
        )
    }
}

