import XCTest
import Vapor
import Domain
import Shared
@testable import Storage
@testable import FluentStorage

class AddUserTaskSpec: XCTestDatabasePreparations {

    private var sut: AddUserTask!
    private var emailValidator: EmailValidator!
    private var verifyFieldTask: VerifyFieldTask!
    private let testUsername = "restart"
    private let testPassword = "123456"
    private let testEmail = "hi@restart.ninja"
    
    override func setUp() {
        super.setUp()
    
        emailValidator = EmailValidator()
        verifyFieldTask = VerifyFieldTask()

        sut = AddUserTask(
            emailValidator: emailValidator,
            verifyFieldTask: verifyFieldTask
        )
    }
    
    override func tearDown() {
        emailValidator = nil
        verifyFieldTask = nil
        sut = nil
        super.tearDown()
    }
    
    func testShould_add_user_if_add_request_is_valid() {
        let request = AddUserRequest(
            username: testUsername,
            password: testPassword,
            email: testEmail
        )
        
        try! sut.execute(request)
        
        XCTAssertEqual(1, try! UserDiskModel.count())
        XCTAssertEqual(testUsername, try! UserDiskModel.all().first?.username)
        XCTAssertEqual(testEmail, try! UserDiskModel.all().first?.email)
    }
    
    func testShould_throw_if_email_is_invalid() {
        let request = AddUserRequest(
            username: testUsername,
            password: testPassword,
            email: "nonas.com"
        )
        
        XCTAssertThrowsError(try sut.execute(request)) { (error) in
            XCTAssertEqual(AddUserError.invalidEmail, error as? AddUserError)
        }
    }
    
    func testShould_throw_if_email_is_already_in_use() {
        givenUser(
            with: testUsername,
            password: testPassword,
            email: testEmail
        )
        
        let request = AddUserRequest(
            username: "otherUserName",
            password: testPassword,
            email: testEmail
        )
        
        XCTAssertThrowsError(try sut.execute(request)) { (error) in
            XCTAssertEqual(AddUserError.emailIsAlreadyInUse, error as? AddUserError)
        }
    }
    
    func testShould_throw_if_username_is_already_in_use() {
        givenUser(
            with: testUsername,
            password: testPassword
        )
        
        let request = AddUserRequest(
            username: testUsername,
            password: testPassword,
            email: testEmail
        )
        
        XCTAssertThrowsError(try sut.execute(request)) { (error) in
            XCTAssertEqual(AddUserError.userNameIsAlreadyInUse, error as? AddUserError)
        }
    }
}
