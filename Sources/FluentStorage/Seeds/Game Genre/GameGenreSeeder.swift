import Fluent

final class GameGenreSeeder: Seeder {
    
    var description: String?
    
    static func prepare(_ database: Database) throws {
        
        let englishLocale = LocaleDiskModel(
            localeIdentifier: "en_US"
        )
        
        try englishLocale.save()
        
        let testGenres = [
            "Fighting", "Graphic Adventure", "Platform", "Vehicle Simulator", "Virtual World", "Shooter"
        ]
        
        try testGenres.forEach { gameGenreName in
            
            let translation = TranslationDiskModel<GameGenreDiskModel>(
                value: gameGenreName,
                localeId: englishLocale.id
            )
            try translation.save()
            
            let gameGenre = GameGenreDiskModel(
                translationId: translation.id
            )
            
            try gameGenre.save()
        }
    }
    
    static func revert(_ database: Database) throws {
        
    }
}
