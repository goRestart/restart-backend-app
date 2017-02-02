import Vapor
import Fluent
import Restart

extension Application {

    func prepare(_ droplet: Droplet) {

        let memoryDriver = MemoryDriver()
        let memoryDatabase = Database(memoryDriver)

        droplet.database = memoryDatabase
        droplet.preparations.append(SuggestionDiskModel.self)
    }
}
