import XCTest
import Fluent
import FluentStorage

public protocol Model: Entity {}

class XCTestDatabasePreparations: XCTestCase {

    public var database: Database!
 
    override func setUp() {
        super.setUp()
        Fluent.autoForeignKeys = false

        let driver = try! MemoryDriver()
        
        database = Database(driver)

        initializeDatabase()
    }
    
    override func tearDown() {
        super.tearDown()
        try! database.revertAll(FluentStorage.preparations)
    }
    
    private func initializeDatabase() {
        try! database.prepare(FluentStorage.preparations)
    }
}
