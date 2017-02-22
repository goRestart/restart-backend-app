import Vapor
import HTTP
import Routing

private struct Path {
    static let user = "user"
}

public struct UserRouteCollection: RouteCollection {

    public typealias Wrapped = HTTP.Responder

    private let userController: UserController

    public init(userController: UserController) {
        self.userController = userController
    }

    public func build<Builder: RouteBuilder>(_ builder: Builder) where Builder.Value == Wrapped {

        builder.post(Path.user) { request in
            return try self.userController.post(request)
        }
    }
}
