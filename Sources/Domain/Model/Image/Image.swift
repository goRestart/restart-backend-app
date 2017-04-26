import Foundation

public struct Image {
    
    public let url: String
    public let width: Double
    public let height: Double
    public let size: Double
    public let color: Int?
    
    public init(url: String,
                width: Double,
                height: Double,
                size: Double,
                color: Int?)
    {
        self.url = url
        self.width = width
        self.height = height
        self.size = size
        self.color = color
    }
}
