import XCTest
@testable import Restart

class SuggestionDiskModelToDomainMapperSpec: XCTestCase {

    static let allTests = [
        ("testShould_map_disk_model_to_domain_model", testShould_map_disk_model_to_domain_model)
    ]

    private var sut: SuggestionDiskModelToDomainMapper!

    override func setUp() {
        super.setUp()
        sut = SuggestionDiskModelToDomainMapper()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func testShould_map_disk_model_to_domain_model() {
        let diskModel = SuggestionDiskModel(
            id: "x85396757n345gsf23ds",
            value: "Mario",
            platform: 3
        )

        let domainModel = sut.map(diskModel)

        XCTAssertEqual("x85396757n345gsf23ds", domainModel.identifier.value)
        XCTAssertEqual("Mario", domainModel.value)
        XCTAssertEqual(.gameboy, domainModel.platform)
    }
}
