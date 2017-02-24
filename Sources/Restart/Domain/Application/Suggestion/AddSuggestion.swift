import Foundation

public struct AddSuggestion {

    private let suggestionRepository: SuggestionRepositoryProtocol

    public init(suggestionRepository: SuggestionRepositoryProtocol) {
        self.suggestionRepository = suggestionRepository
    }

    @discardableResult
    public func add(suggestion: String, platform: Platform) throws -> Suggestion {
        return try suggestionRepository.add(suggestion: suggestion, platform: platform)
    }
}
