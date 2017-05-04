import XCTest
import Domain
@testable import Storage

class VerifyFieldTaskSpec: XCTestDatabasePreparations {
    
    private var sut: VerifyFieldTask!
    private let testUsername = "restart"
    private let testPassword = "123456"
    private let testEmail = "hi@restart.ninja"
    
    override func setUp() {
        super.setUp()
    
        sut = VerifyFieldTask()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func testShould_throw_if_email_is_already_being_used() {
        givenUser(
            with: testUsername,
            password: testPassword,
            email: testEmail
        )
        
        XCTAssertThrowsError(try sut.execute(.email(testEmail))) { (error) in
            XCTAssertEqual(AddUserError.emailIsAlreadyInUse, error as? AddUserError)
        }
    }
    
    func testShould_not_throw_if_email_is_correct() {
        XCTAssertNoThrow(try sut.execute(.email(testEmail)))
    }
    
    func testShould_throw_if_email_is_already_used_ignoring_case_sensitive() {
        givenUser(
            with: testUsername,
            password: testPassword
        )
        XCTAssertThrowsError(try sut.execute(.email(testEmail.uppercased()))) { (error) in
            XCTAssertEqual(AddUserError.emailIsAlreadyInUse, error as? AddUserError)
        }
    }
    
    func testShould_throw_if_username_is_already_being_used() {
        givenUser(
            with: testUsername,
            password: testPassword,
            email: testEmail
        )
        
        XCTAssertThrowsError(try sut.execute(.username(testUsername))) { (error) in
            XCTAssertEqual(AddUserError.userNameIsAlreadyInUse, error as? AddUserError)
        }
    }
    
    func testShould_not_throw_if_username_is_correct() {
        XCTAssertNoThrow(try sut.execute(.email(testEmail)))
    }
    
    func testShould_throw_if_username_is_already_used_ignoring_case_sensitive() {
        givenUser(
            with: testUsername,
            password: testPassword
        )
        XCTAssertThrowsError(try sut.execute(.username(testUsername.uppercased()))) { (error) in
            XCTAssertEqual(AddUserError.userNameIsAlreadyInUse, error as? AddUserError)
        }
    }
}
