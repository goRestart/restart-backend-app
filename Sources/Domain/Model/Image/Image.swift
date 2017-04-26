import Foundation

public struct Image {
    
    public let identifier: String
    public let url: String
    public let width: Double
    public let height: Double
    public let size: Double
    public let color: Int?
    
    public init(identifier: String,
                url: String,
                width: Double,
                height: Double,
                size: Double,
                color: Int?)
    {
        self.identifier = identifier
        self.url = url
        self.width = width
        self.height = height
        self.size = size
        self.color = color
    }
}
