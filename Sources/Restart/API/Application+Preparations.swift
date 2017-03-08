import Vapor
import Fluent
import VaporMySQL
import VaporRedis
import ServiceLocator

extension Application {

    func prepare(_ droplet: Droplet) throws {

        try droplet.addProvider(VaporMySQL.Provider.self)
        try droplet.addProvider(VaporRedis.Provider.self)

        let apiAuthMiddleware = Dependency().getApiAuthMiddleware()

        droplet.addConfigurable(
            middleware: apiAuthMiddleware,
            name: String(describing: apiAuthMiddleware)
        )

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
