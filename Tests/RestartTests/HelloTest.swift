import XCTest
@testable import Restart

class HelloTest: XCTestCase {

    static let allTests = [ 
        ("testHello", testHello)
    ]

    func testHello() {
        XCTAssertEqual("hello", "hello")
    }
}
