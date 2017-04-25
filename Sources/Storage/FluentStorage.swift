import Vapor
import Fluent
import FluentProvider

public struct FluentStorage {
    
    public static func initialize(_ droplet: Droplet) {
        droplet.preparations += preparations
    }
    
    private static let preparations: [Preparation.Type] = [
        // Developer
        ApiKeyDiskModel.self,
        UserSessionDiskModel.self,
        
        // Generic 
        LocaleDiskModel.self,
        ImageDiskModel.self,
        LocationDiskModel.self,
        PriceDiskModel.self,
        PlatformDiskModel.self,

        // User
        GenderDiskModel.self,
        UserDiskModel.self,
        
        // Product
        ProductDiskModel.self,
        ImageCollectionDiskModel.self,
        ViewCountDiskModel.self
    ]
}
