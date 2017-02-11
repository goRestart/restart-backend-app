import Vapor
import HTTP
import JSON

private struct Params {
    static let query = "query"
    static let suggestion = "suggestion"
    static let platform = "platform"
}

public struct SuggestionController {

    private let getSuggestionsWithQuery: GetSuggestionsWithQuery
    private let addSuggestion: AddSuggestion

    public init(getSuggestionsWithQuery: GetSuggestionsWithQuery,
         addSuggestion: AddSuggestion)
    {
        self.getSuggestionsWithQuery = getSuggestionsWithQuery
        self.addSuggestion = addSuggestion
    }

    func get(_ request: Request) throws -> ResponseRepresentable {
        guard let query = request.data[Params.query]?.string else {
            throw Abort.custom(status: .badRequest, message: "Invalid request, missing query parameter")
        }
        let suggestions = try? getSuggestionsWithQuery.get(query).makeNode()
        return try JSON(node: suggestions)
    }

    func add(_ request: Request) throws -> ResponseRepresentable {
        guard let suggestion = request.data[Params.suggestion]?.string else {
            throw Abort.badRequest
        }
        let platform = buildPlatformWith(request)

        let newSuggestion = try? addSuggestion.add(suggestion: suggestion, platform: platform)
        return try JSON(node: newSuggestion)
    }

    // MARK: - Helper 

    private func buildPlatformWith(_ request: Request) -> Platform {
        var defaultPlatform: Platform = .other
        if let platformIndex = request.data[Params.platform]?.int,
           let platform = Platform(rawValue: platformIndex)
        {
            defaultPlatform = platform
        }
        return defaultPlatform
    }
}
