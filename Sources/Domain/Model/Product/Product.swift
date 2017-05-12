import Foundation

public struct Product {
    
    public let identifier: String
    public let description: String
    public let images: [Image]
    public let price: Price
    public let platform: Platform
    public let location: Location
    public let seller: User
    public let game: Game
    public let views: Int
    
    public init(identifier: String,
                description: String,
                images: [Image],
                price: Price,
                platform: Platform,
                location: Location,
                seller: User,
                game: Game,
                views: Int)
    {
        self.identifier = identifier
        self.description = description
        self.images = images
        self.price = price
        self.platform = platform
        self.location = location
        self.seller = seller
        self.game = game
        self.views = views
    }
}
