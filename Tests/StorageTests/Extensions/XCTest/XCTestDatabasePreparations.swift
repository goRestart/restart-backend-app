import XCTest
import FluentProvider
import Fluent
import Vapor

public protocol Model: Entity {}

class XCTestDatabasePreparations: XCTestCase {

    private var drop: Droplet!
    private var memoryDriver: MemoryDriver!
    private var memoryDatabase: Database!

    override func setUp() {
        super.setUp()
        
        drop = try! getDroplet()

        memoryDriver = try! MemoryDriver()
        memoryDatabase = Database(memoryDriver)

        drop.config.addConfigurable(driver: MemoryDriver.init, name: "memory-driver")
        
        try! drop.config.addProvider(FluentProvider.Provider)
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
        
        drop.config.preparations = models.map { $0 as! Preparation.Type }
        
        // We don't want to run our entire webserver so we need to make this
        // hack so we only initialize providers without firing up server
        for provider in drop.config.providers {
            try! provider.beforeRun(drop)
        }
    }

    func prepare(_ model: Entity.Type) {
        prepare([model])
    }
}

