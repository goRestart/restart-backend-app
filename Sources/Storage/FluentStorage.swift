import Vapor
import Fluent

public struct FluentStorage {
    
    public static let preparations: [Preparation.Type] = [
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
