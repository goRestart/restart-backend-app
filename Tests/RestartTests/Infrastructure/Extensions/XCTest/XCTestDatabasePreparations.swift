import XCTest
import FluentProvider
import Fluent
import Vapor
@testable import Restart

public protocol Model: Entity {}

class XCTestDatabasePreparations: XCTestCase {

    private let drop = try! Droplet()
    private var memoryDriver: MemoryDriver!
    private var memoryDatabase: Database!

    override func setUp() {
        super.setUp()

        memoryDriver = try! MemoryDriver()
        memoryDatabase = Database(memoryDriver)

        drop.database = memoryDatabase
            
        try! drop.addProvider(FluentProvider.Provider)
    }
    
    override func tearDown() {
        memoryDriver = nil
        memoryDatabase = nil
        super.tearDown()
    }

    func prepare(_ models: [Entity.Type]) {
        models.forEach { model in
            model.database = memoryDatabase
        }
        
        drop.preparations = models.map { $0 as! Preparation.Type }
        
        // We don't want to run our entire webserver so we need to make this
        // hack so we only initialize providers without firing up server
        for provider in drop.providers {
            try! provider.beforeRun(drop)
        }
    }

    func prepare(_ model: Entity.Type) {
        prepare([model])
    }
}
