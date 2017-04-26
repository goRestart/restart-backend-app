import Foundation

public struct Product {
    
    public let identifier: String
    public let title: String
    public let description: String
    public let price: Price
    public let platform: Platform
    public let location: Location
    public let seller: User
    public let imageCollection: ImageCollection
    public let views: Int
    
    public init(identifier: String,
                title: String,
                description: String,
                price: Price,
                platform: Platform,
                location: Location,
                seller: User,
                imageCollection: ImageCollection,
                views: Int)
    {
        self.identifier = identifier
        self.title = title
        self.description = description
        self.price = price
        self.platform = platform
        self.location = location
        self.seller = seller
        self.imageCollection = imageCollection
        self.views = views
    }
}
