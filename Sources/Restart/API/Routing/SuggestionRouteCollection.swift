import Vapor
import HTTP
import Routing

private struct Path {
    static let suggestion = "suggestion"
}

public struct SuggestionRouteCollection: RouteCollection {

    public typealias Wrapped = HTTP.Responder

    private let suggestionController: SuggestionController

    public init(suggestionController: SuggestionController) {
        self.suggestionController = suggestionController
    }

    public func build<Builder: RouteBuilder>(_ builder: Builder) where Builder.Value == Wrapped {
        builder.get(Path.suggestion) { request in
            return "todo"
        }

        builder.post(Path.suggestion) { request in
            return "todo"
        }
    }
}
