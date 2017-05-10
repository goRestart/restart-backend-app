import Foundation

public struct AddProductRequest {
    public let title: String
    public let description: String
    public let price: Price
    
    public init(title: String, description: String, price: Price) {
        self.title = title
        self.description = description
        self.price = price
    }
}
