import Vapor
import Fluent
import VaporMySQL
import VaporRedis

extension Application {

    func prepare(_ droplet: Droplet) throws {

        try droplet.addProvider(VaporMySQL.Provider.self)
        try droplet.addProvider(VaporRedis.Provider.self)

        droplet.preparations = [
            UserDiskModel.self,
            ImageDiskModel.self,
            LocationDiskModel.self,
            LocaleDiskModel.self,
            ApiKeyDiskModel.self,
            UserSessionDiskModel.self
        ]
    }
}
