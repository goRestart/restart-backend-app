import XCTest
@testable import Restart

class InMemorySessionDiskDataSourceSpec: XCTestCase {

    static let allTests = [
        ("testShould_store_session_in_memory", testShould_store_session_in_memory)
    ]

    private var sut: InMemorySessionDataSource!
    private var sessionCache: SessionCacheSpy!
    private let userSessionDiskModelToDomainMapper = UserSessionDiskModelToDomainMapper()

    override func setUp() {
        super.setUp()

        sessionCache = SessionCacheSpy()
        sut = InMemorySessionDataSource(
            memoryCache: sessionCache
        )
    }

    override func tearDown() {
        sessionCache = nil
        sut = nil
        super.tearDown()
    }

    func testShould_store_session_in_memory() {
        let addSessionRequest = AddSessionRequest(
            userId: "8798af98dafdsf98sdf",
            validityInterval: 100
        )

        try! sut.store(addSessionRequest)

        XCTAssertTrue(sessionCache.setWithExpirationExecuted)
        XCTAssertNotNil(sessionCache.setWithExpirationValue)
    }
}
