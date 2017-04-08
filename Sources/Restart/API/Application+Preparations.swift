import Vapor
import Fluent
import RedisProvider
import ServiceLocator

extension Application {

    func prepare(_ droplet: Droplet) throws {

        try droplet.addProvider(RedisProvider.Provider)

        let apiAuthMiddleware = Dependency().getApiAuthMiddleware()

        droplet.addConfigurable(
            middleware: apiAuthMiddleware,
            name: String(describing: "api-auth")
        )
        
        droplet.preparations = [
            UserDiskModel.self,
            GenderDiskModel.self,
            ImageDiskModel.self,
            LocationDiskModel.self,
            LocaleDiskModel.self,
            ApiKeyDiskModel.self,
            UserSessionDiskModel.self
        ]
    }
}
