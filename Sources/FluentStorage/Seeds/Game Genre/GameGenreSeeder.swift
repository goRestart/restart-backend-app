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
            (en: "Fighting", es: "Pelea"),
            (en: "Platform", es: "Plataforma"),
            (en: "Shooter", es: "Disparos")
        ]
        
        try testGenres.forEach { gameGenreName in

            let gameGenre = GameGenreDiskModel()
            try gameGenre.save()
            
            let englishTranslation = TranslationDiskModel<GameGenreDiskModel>(
                value: gameGenreName.en,
                parentId: gameGenre.id,
                localeId: englishLocale.id
            )
            try englishTranslation.save()
            
            let spanishTranslation = TranslationDiskModel<GameGenreDiskModel>(
                value: gameGenreName.es,
                parentId: gameGenre.id,
                localeId: spanishLocale.id
            )
            try spanishTranslation.save()
        }
    }
    
    static func revert(_ database: Database) throws {
        
    }
}
