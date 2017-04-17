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

        XCTAssertEqual("efb94009820a6f239183d4a28f7ea618bff1b8bd361788ed1012b6ba59541108", hashedString)
    }
}
