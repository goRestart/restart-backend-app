import XCTest
@testable import Storage
@testable import FluentStorage

class GameDiskDataSourceSpec: XCTestDatabasePreparations {
    
    private var sut: GameDiskDataSource!
    private var platformDiskModelToDomainMapper: PlatformDiskModelToDomainMapper!
    
    override func setUp() {
        super.setUp()
        
        platformDiskModelToDomainMapper = PlatformDiskModelToDomainMapper()
        
        sut = GameDiskDataSource(
            platformDiskModelToDomainMapper: platformDiskModelToDomainMapper
        )
    }
    
    override func tearDown() {
        platformDiskModelToDomainMapper = nil
        sut = nil
        super.tearDown()
    }
    
    func testShould_return_empty_list_if_there_are_no_platforms_in_db() {
        let platforms = try! sut.getAllPlatforms()
        XCTAssertEqual(0, platforms.count)
    }
    
    func testShould_return_platforms_if_there_are_items_on_db() {
        givenThereArePlatforms()
        
        let platforms = try! sut.getAllPlatforms()
        XCTAssertTrue(platforms.count > 0)
    }
    
    // MARK: - Helper
    
    private func givenThereArePlatforms() {
        try! PlatformSeeder.prepare(database)
    }
}
