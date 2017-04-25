import XCTest
import Storage
import Vapor
@testable import Storage

class PasswordHasherSpec: XCTestCase {

    static let allTests = [
        ("testShould_generate_the_correct_password_hash", testShould_generate_the_correct_password_hash)
    ]

    private var sut: PasswordHasher!
    private var droplet: Droplet!
    
    override func setUp() {
        super.setUp()
        
        droplet = try! getDroplet()
        sut = PasswordHasher(
            hasher: droplet.hash
        )
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testShould_generate_the_correct_password_hash() {
        let passwordToHash = "Restart is going to rock you world ❤️"
        let salt = UUID().uuidString
        
        let signature = sut.signature(
            username: "skyweb07",
            password: passwordToHash,
            salt: salt
        )
        let hashedPassword = try! sut.hash(signature)

        XCTAssertTrue(try sut.check(input: signature, matches: hashedPassword))
    }
}
