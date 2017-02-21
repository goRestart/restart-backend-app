import Vapor
import ServiceLocator
import Restart

let application = Dependency().getApplication()

do {
    try application.run()
} catch {
    print(error)
}
