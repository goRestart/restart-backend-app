import XCTest
@testable import Restart

class SessionDiskDataSourceSpec: XCTestDatabasePreparations {

    static let allTests = [
        ("testShould_store_session_in_disk", testShould_store_session_in_disk)
    ]

    private var sut: SessionDiskDataSource!
    private let userSessionDiskModelToDomainMapper = UserSessionDiskModelToDomainMapper()

    override func setUp() {
        super.setUp()
        prepare(UserSessionDiskModel.self)

        sut = SessionDiskDataSource(
            userSessionDiskModelToDomainMapper: userSessionDiskModelToDomainMapper
        )
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func testShould_store_session_in_disk() {
        let addSessionRequest = AddSessionRequest(
            userId: "8798af98dafdsf98sdf",
            validityInterval: 100
        )

        try! sut.store(addSessionRequest)

        XCTAssertEqual(1, try! UserSessionDiskModel.all().count)
    }
}
