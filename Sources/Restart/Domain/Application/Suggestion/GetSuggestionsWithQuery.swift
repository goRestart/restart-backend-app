import Foundation

public struct GetSuggestionsWithQuery {

    private let suggestionRepository: SuggestionRepositoryProtocol

    public init(suggestionRepository: SuggestionRepositoryProtocol) {
        self.suggestionRepository = suggestionRepository
    }

    public func get(_ query: String) -> [Suggestion] {
        return suggestionRepository.get(with: query)
    }
}
