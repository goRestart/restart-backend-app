import XCTest
@testable import Restart

class SessionRepositorySpec: XCTestCase {

    static let allTests = [
        ("testShould_call_store_in_data_sources", testShould_call_store_in_data_sources),
        ("testShould_store_session_in_disk_if_memory_fails", testShould_store_session_in_disk_if_memory_fails)
    ]

    private var sut: SessionRepository!
    private var inMemorySessionDataSource: SessionDataSourceMock!
    private var diskSessionDataSource: SessionDataSourceMock!

    override func setUp() {
        super.setUp()

        inMemorySessionDataSource = SessionDataSourceMock()
        diskSessionDataSource = SessionDataSourceMock()

        sut = SessionRepository(
            inMemorySessionDataSource: inMemorySessionDataSource,
            diskSessionDataSource: diskSessionDataSource
        )
    }
    
    override func tearDown() {
        inMemorySessionDataSource = nil
        diskSessionDataSource = nil
        sut = nil
        super.tearDown()
    }

    func testShould_call_store_in_data_sources() {
        let addSessionRequest = givenValidSessionRequest()

        try! sut.store(addSessionRequest)

        XCTAssertTrue(inMemorySessionDataSource.storeExecuted)
        XCTAssertTrue(diskSessionDataSource.storeExecuted)
    }

    func testShould_store_session_in_disk_if_memory_fails() {
        let addSessionRequest = givenValidSessionRequest()
        inMemorySessionDataSource.errorToThrow = SessionDataError.unknown

        try! sut.store(addSessionRequest)

        XCTAssertTrue(diskSessionDataSource.storeExecuted)
    }

    // MARK: - Helpers

    func givenValidSessionRequest() -> AddSessionRequest {
        return AddSessionRequest(
            userId: "8798af98dafdsf98sdf",
            validityInterval: 100
        )
    }
}
