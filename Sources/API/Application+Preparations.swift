import Vapor
import Fluent
import RedisProvider
import MySQLProvider
import ServiceLocator

extension Application {

    func prepare(_ droplet: Droplet) throws {

        try droplet.addProvider(RedisProvider.Provider)
        try droplet.addProvider(MySQLProvider.Provider)
        
        //let apiAuthMiddleware = Dependency().getApiAuthMiddleware()

//        droplet.addConfigurable(
//            middleware: apiAuthMiddleware,
//            name: String(describing: "api-auth")
//        )
//        
//        droplet.preparations = [
//            GenderDiskModel.self,
//            ImageDiskModel.self,
//            LocationDiskModel.self,
//            LocaleDiskModel.self,
//            ApiKeyDiskModel.self,
//            UserSessionDiskModel.self,
//            UserDiskModel.self
//        ]
    }
}
