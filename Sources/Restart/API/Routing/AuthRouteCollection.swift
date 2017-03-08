import Vapor
import HTTP
import Routing

private struct Path {
    static let auth = "auth"
}

public struct AuthRouteCollection: RouteCollection {

    public typealias Wrapped = HTTP.Responder

    private let apiAuthMiddleware: ApiAuthMiddleware
    private let authController: AuthController

    public init(apiAuthMiddleware: ApiAuthMiddleware,
                authController: AuthController)
    {
        self.apiAuthMiddleware = apiAuthMiddleware
        self.authController = authController
    }

    public func build<Builder: RouteBuilder>(_ builder: Builder) where Builder.Value == Wrapped {
        builder.group(apiAuthMiddleware) { authorized in
            authorized.post(Path.auth) { request in
                return try self.authController.post(request)
            }
        }
    }
}
