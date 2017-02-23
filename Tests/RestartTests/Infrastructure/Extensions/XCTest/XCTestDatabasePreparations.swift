import XCTest
import Fluent
import Vapor

class XCTestDatabasePreparations: XCTestCase {

    private let drop = Droplet()
    private var memoryDriver: MemoryDriver!
    private var memoryDatabase: Database!

    override func setUp() {
        super.setUp()

        memoryDriver = MemoryDriver()
        memoryDatabase = Database(memoryDriver)

        drop.database = memoryDatabase
    }
    
    override func tearDown() {
        memoryDriver = nil
        memoryDatabase = nil
        super.tearDown()
    }

    func prepare(_ models: [Model.Type]) {
        drop.preparations = models

        models.forEach { model in
            model.database = memoryDatabase
        }
    }

    func prepare(_ model: Model.Type) {
        prepare([model])
    }
}
