import Fluent

final class PlatformSeeder: Seeder {
    
    var description: String? = "Seed db with some test platforms"
    
    static func prepare(_ database: Database) throws {
        let platforms = ["PC", "Xbox", "PS4", "Xbox One", "PS3"]
        
        try platforms.forEach { name in
            let platform = PlatformDiskModel(
                name: name
            )
            try platform.save()
        }
    }
    
    static func revert(_ database: Database) throws {
        
    }
}
