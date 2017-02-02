import Foundation

public protocol SuggestionRepositoryProtocol {
    func add(suggestion: String, platform: Platform) throws -> Suggestion
    func get(with query: String) -> [Suggestion]
}
