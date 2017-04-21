import Routing

private struct Path {
    static let auth = "auth"
}

public struct AuthRouteCollection {

    private let apiAuthMiddleware: ApiAuthMiddleware
    private let authController: AuthController

    public init(apiAuthMiddleware: ApiAuthMiddleware,
                authController: AuthController)
    {
        self.apiAuthMiddleware = apiAuthMiddleware
        self.authController = authController
    }
    
    public func build(_ builder: RouteBuilder) {
        builder.group(apiAuthMiddleware) { authorized in
            authorized.post(Path.auth) { request in
                return try self.authController.post(request)
            }
        }
    }
}
