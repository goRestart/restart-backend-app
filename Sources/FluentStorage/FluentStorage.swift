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
        ImageCollectionDiskModel.self,
        ProductDiskModel.self,
        ViewCountDiskModel.self,
        
        // Game
        GameGenreDiskModel.self,
        GameDiskModel.self,
        TranslationDiskModel<GameGenreDiskModel>.self
    ]
    
    public static let seeders: [Preparation.Type] = [
        // Seeders
        PlatformSeeder.self,
        GameGenreSeeder.self
    ]
}
