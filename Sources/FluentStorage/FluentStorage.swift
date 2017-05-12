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
        ViewCountDiskModel.self,
        Pivot<ProductDiskModel, ImageDiskModel>.self,
        
        // Game
        GameGenreDiskModel.self,
        GameAlternativeNameDiskModel.self,
        GameCompanyDiskModel.self,
        GameDiskModel.self,
        Pivot<GameDiskModel, ImageDiskModel>.self,
        Pivot<GameDiskModel, GameAlternativeNameDiskModel>.self,
        Pivot<GameDiskModel, PlatformDiskModel>.self,
        Pivot<GameDiskModel, GameGenreDiskModel>.self,
        TranslationDiskModel<GameGenreDiskModel>.self
    ]
    
    public static let seeders: [Preparation.Type] = [
        PlatformSeeder.self,
        GameGenreSeeder.self,
        GameSeeder.self
    ]
}
