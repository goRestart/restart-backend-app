import ServiceLocator
import Vapor
import Shared

extension Assembly {
    
    public func getApplication() -> Application {
        return Application(
            droplet: getDroplet(),
            router: getRouter()
        )
    }
}
