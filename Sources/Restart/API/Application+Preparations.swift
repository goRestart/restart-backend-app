import Vapor
import Fluent
import VaporMySQL

extension Application {

    func prepare(_ droplet: Droplet) throws {

        try droplet.addProvider(VaporMySQL.Provider.self)

        droplet.preparations = [
            SuggestionDiskModel.self,
            UserDiskModel.self,
            ImageDiskModel.self,
            LocationDiskModel.self,
            LocaleDiskModel.self
        ]
    }
}
