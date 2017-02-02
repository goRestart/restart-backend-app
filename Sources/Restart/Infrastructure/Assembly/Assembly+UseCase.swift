import ServiceLocator
import Restart

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
