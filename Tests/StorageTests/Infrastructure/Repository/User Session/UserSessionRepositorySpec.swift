import XCTest
import Domain
@testable import Storage

class UserSessionRepositorySpec: XCTestCase {

    static let allTests = [
        ("testShould_call_store_in_data_sources", testShould_call_store_in_data_sources),
        ("testShould_store_session_in_disk_if_memory_fails", testShould_store_session_in_disk_if_memory_fails)
    ]

    private var sut: UserSessionRepository!

    fileprivate var inMemoryUserSessionDataSource: UserSessionDataSourceMock!
    private var diskUserSessionDataSource: UserSessionDataSourceMock!

    override func setUp() {
        super.setUp()

        inMemoryUserSessionDataSource = UserSessionDataSourceMock()
        diskUserSessionDataSource = UserSessionDataSourceMock()

        sut = UserSessionRepository(
            userSessionDataSourceProvider: self,
            diskUserSessionDataSource: diskUserSessionDataSource
        )
    }
    
    override func tearDown() {
        inMemoryUserSessionDataSource = nil
        diskUserSessionDataSource = nil
        sut = nil
        super.tearDown()
    }

    func testShould_call_store_in_data_sources() {
        let addSessionRequest = givenValidSessionRequest()

        try! sut.store(addSessionRequest)

        XCTAssertTrue(inMemoryUserSessionDataSource.storeExecuted)
        XCTAssertTrue(diskUserSessionDataSource.storeExecuted)
    }

    func testShould_store_session_in_disk_if_memory_fails() {
        let addSessionRequest = givenValidSessionRequest()
        inMemoryUserSessionDataSource.errorToThrow = SessionDataError.unknown

        try! sut.store(addSessionRequest)

        XCTAssertTrue(diskUserSessionDataSource.storeExecuted)
    }

    // MARK: - Helpers

    func givenValidSessionRequest() -> AddSessionRequest {
        return AddSessionRequest(
            userId: "8798af98dafdsf98sdf",
            validityInterval: 100
        )
    }
}

// MARK: - Extensions

extension UserSessionRepositorySpec: UserSessionDataSourceProvider {

    func inMemory() -> UserSessionDataSource {
        return inMemoryUserSessionDataSource
    }
}
