import Vapor
import Fluent

public struct FluentStorage {
    
    public static func initialize(_ droplet: Droplet) {
        droplet.preparations += preparations
    }
    
    private static let preparations: [Preparation.Type] = [
        
        // Developer
        ApiKeyDiskModel.self,
        UserSessionDiskModel.self,
        
        // Generic 
        ImageDiskModel.self,
        LocationDiskModel.self,

        // User
        GenderDiskModel.self,
        LocaleDiskModel.self,
        UserDiskModel.self
    ]
}
