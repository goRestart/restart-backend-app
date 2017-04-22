import Routing

private struct Path {
    static let user = "user"
}

public struct UserRouteCollection {

    private let userController: UserController

    public init(userController: UserController) {
        self.userController = userController
    }
    
    public func build(_ builder: RouteBuilder) {
        builder.post(Path.user) { request in
            return try self.userController.post(request)
        }
    }
}
