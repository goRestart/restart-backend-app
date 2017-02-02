import Foundation

public struct SuggestionRepository: SuggestionRepositoryProtocol {

    private let diskDataSource: SuggestionDataSource

    public init(diskDataSource: SuggestionDataSource) {
        self.diskDataSource = diskDataSource
    }

    public func add(suggestion: String, platform: Platform) throws -> Suggestion {
        return try diskDataSource.add(suggestion: suggestion, platform: platform)
    }

    public func get(with query: String) -> [Suggestion] {
        return diskDataSource.get(with: query)
    }
}
