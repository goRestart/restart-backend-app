import Vapor
import ServiceLocator
import Restart

let application = Dependency().getApplication()
application.run()
