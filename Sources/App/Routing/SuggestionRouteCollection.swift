import Vapor
import HTTP
import Routing

private struct Path {
    static let suggestion = "suggestion"
}

struct SuggestionRouteCollection: RouteCollection {

    typealias Wrapped = HTTP.Responder

    private let suggestionController: SuggestionController

    public init(suggestionController: SuggestionController) {
        self.suggestionController = suggestionController
    }

    func build<Builder: RouteBuilder>(_ builder: Builder) where Builder.Value == Wrapped {
        builder.get(Path.suggestion) { request in
            return try self.suggestionController.get(request)
        }

        builder.post(Path.suggestion) { request in
            return try self.suggestionController.add(request)
        }
    }
}
