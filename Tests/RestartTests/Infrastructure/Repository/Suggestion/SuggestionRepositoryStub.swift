import Foundation
@testable import Restart

final class SuggestionRepositoryStub: SuggestionRepositoryProtocol {

    var suggestions = [Suggestion]()

    func add(suggestion: String, platform: Platform) throws -> Suggestion {
        let newSuggestion = Suggestion(
            identifier: Identifier.make(),
            value: suggestion,
            platform: platform
        )
        suggestions.append(newSuggestion)
        return newSuggestion
    }

    func get(with query: String) -> [Suggestion] {
        return suggestions.filter { suggestion in
            suggestion.value.lowercased().contains(query.lowercased())
        }
    }
}
