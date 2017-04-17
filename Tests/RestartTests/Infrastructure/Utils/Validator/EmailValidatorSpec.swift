import XCTest
@testable import Restart

class EmailValidatorSpec: XCTestCase {

    static let allTests = [
        ("testShould_return_false_when_email_is_invalid", testShould_return_false_when_email_is_invalid),
        ("testShould_return_true_when_email_is_valid", testShould_return_true_when_email_is_valid),
        ("testShould_return_false_when_email_lenght_is_incorrect", testShould_return_false_when_email_lenght_is_incorrect)
    ]

    private let sut = EmailValidator()

    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testShould_return_false_when_email_is_invalid() {
        let invalidEmail1 = "despacito@"
        let invalidEmail2 = "favoritos@com"
        let invalidEmail3 = "fonsihot.com"

        XCTAssertFalse(sut.validate(invalidEmail1))
        XCTAssertFalse(sut.validate(invalidEmail2))
        XCTAssertFalse(sut.validate(invalidEmail3))
    }
    
    func testShould_return_true_when_email_is_valid() {
        let validEmail = "hi@oduran.me"

        XCTAssertTrue(sut.validate(validEmail))
    }

    func testShould_return_false_when_email_lenght_is_incorrect() {
        let invalidEmail = "a@a.io"

        XCTAssertFalse(sut.validate(invalidEmail))
    }
}
