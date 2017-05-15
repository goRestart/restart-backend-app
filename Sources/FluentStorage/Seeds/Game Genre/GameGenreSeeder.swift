import Fluent

final class GameGenreSeeder: Seeder {
    
    var description: String? = "Seed db with some test game genres"
    
    static func prepare(_ database: Database) throws {
        
        let englishLocale = LocaleDiskModel(
            localeIdentifier: "en_US"
        )

        let spanishLocale = LocaleDiskModel(
            localeIdentifier: "es_ES"
        )

        try englishLocale.save()
        try spanishLocale.save()
        
        let testGenres = [
            (en: "Fighting", es: "Pelea")
        ]
        
        try testGenres.forEach { gameGenreName in

            let gameGenre = GameGenreDiskModel()
            try gameGenre.save()
            
            
            let englishTranslation = Localizable<GameGenreDiskModel>(
                value: gameGenreName.en,
                key: "game_genre_name",
                localeId: englishLocale.id
            )
 
            try englishTranslation.save()

            let spanishTranslation = Localizable<GameGenreDiskModel>(
                value: gameGenreName.es,
                key: "game_genre_name",
                localeId: spanishLocale.id
            )
            try spanishTranslation.save()
        }
    }
    
    static func revert(_ database: Database) throws {
        
    }
}
