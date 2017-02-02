import Foundation

public protocol SuggestionDataSource {
    func add(suggestion: String, platform: Platform) throws -> Suggestion
    func get(with query: String) -> [Suggestion]
}
