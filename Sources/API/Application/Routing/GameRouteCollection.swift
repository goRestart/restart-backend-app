import Routing

private struct Path {
    static let base = "game/"
    static let platforms = base + "platforms"
}

public struct GameRouteCollection {
    
    private let gameController: GameController
    
    public init(gameController: GameController) {
        self.gameController = gameController
    }
    
    public func build(_ builder: RouteBuilder) {
        builder.get(Path.platforms) { request in
            return try self.gameController.getPlatforms()
        }
    }
}
