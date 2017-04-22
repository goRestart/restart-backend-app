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

        // User
        GenderDiskModel.self,
        UserDiskModel.self
    ]
}
