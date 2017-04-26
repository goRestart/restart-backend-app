import Foundation

public struct ImageCollection {
    
    public let identifier: String
    public let images: [Image]
    public let mainImage: Image
    
    public init(identifier: String, images: [Image], mainImage: Image) {
        precondition(images.count > 0, "Image list can't be empty")
        
        self.identifier = identifier
        self.images = images
        self.mainImage = mainImage
    }
}
