import XCTest
import Domain
@testable import Storage

class InMemoryUserSessionDiskDataSourceSpec: XCTestCase {

    static let allTests = [
        ("testShould_store_session_in_memory", testShould_store_session_in_memory)
    ]

    private var sut: InMemoryUserSessionDataSource!
    private var sessionCache: UserSessionCacheSpy!
    private let userSessionDiskModelToDomainMapper = UserSessionDiskModelToDomainMapper()

    override func setUp() {
        super.setUp()

        sessionCache = UserSessionCacheSpy()
        sut = InMemoryUserSessionDataSource(
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
