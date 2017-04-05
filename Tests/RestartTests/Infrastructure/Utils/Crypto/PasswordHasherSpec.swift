import XCTest
import Vapor

@testable import Restart

class PasswordHasherSpec: XCTestCase {

    static let allTests = [
        ("testShould_generate_the_correct_password_hash", testShould_generate_the_correct_password_hash)
    ]

    private var sut: PasswordHasher!
    private let droplet = try! Droplet()

    override func setUp() {
        super.setUp()
        sut = PasswordHasher(
            hasher: droplet.hash
        )
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testShould_generate_the_correct_password_hash() {
        let passwordToHash = "Restart is going to rick you world ❤️"
        let hashedString = sut.hash(
            userName: "skyweb07",
            password: passwordToHash
        )

        XCTAssertEqual("59f2f3924d4b5358361235c1f3bae02669c6790a7d8eadbada2f402d5c63db94", hashedString)
    }
}
