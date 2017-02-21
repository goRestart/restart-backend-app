import Vapor
import Fluent
import VaporMySQL

extension Application {

    func prepare(_ droplet: Droplet) throws {

        try droplet.addProvider(VaporMySQL.Provider.self)

        droplet.preparations = [
            SuggestionDiskModel.self
        ]
    }
}
