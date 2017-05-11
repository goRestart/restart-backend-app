import Fluent

final class GameSeeder: Seeder {
    
    var description: String? = "Seed db with some test games"
    
    static func prepare(_ database: Database) throws {
        let platform = PlatformDiskModel(
            name: "PS1"
        )
        try platform.save()
 
        let game = GameDiskModel(
            title: "Metal Gear Solid",
            description: "Metal Gear Solid (original Japanese name: Metal Gear: Ghost Babel) for GameBoy Color is not the same game as the popular Playstation/PC installment of the series. It is not set within the storyline of Metal Gear series, but instead tells an unrelated episode featuring the same hero - special agent Solid Snake. A secret government project, codenamed \"Babel\", attempts to revive the Metal Gear project - development of a highly destructive mech weapon."
        )
        try game.save()
        
        try game.platforms().add(platform)
        
        try GameGenreDiskModel.all().forEach { element in
            try game.genres().add(element)
        }
    }
    
    static func revert(_ database: Database) throws {
        
    }
}
