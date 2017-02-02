import Foundation
import Core

public struct SuggestionDiskDataSource: SuggestionDataSource {

    private let mapper: SuggestionDiskModelToDomainMapper

    public init(mapper: SuggestionDiskModelToDomainMapper) {
        self.mapper = mapper
    }

    @discardableResult
    public func add(suggestion: String, platform: Platform) throws -> Suggestion {
        var newSuggestion = SuggestionDiskModel(
            id: Identifier.make().value,
            value: suggestion,
            platform: platform.rawValue
        )
        try newSuggestion.save()
        return mapper.map(newSuggestion)
    }

    public func get(with query: String) -> [Suggestion] {
        guard let results = try? SuggestionDiskModel.query().all() else {
            return []
        }
        return mapper.map(
            array: results.filter {
                $0.value.lowercased().contains(query.lowercased())
            }
        )
    }
}
