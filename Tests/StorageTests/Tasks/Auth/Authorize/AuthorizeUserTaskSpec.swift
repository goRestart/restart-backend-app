import XCTest
import Vapor
import Domain
@testable import Storage

class AuthorizeUserTaskSpec: XCTestDatabasePreparations {
    
    private var sut: AuthorizeUserTask!
    private var passwordHasher: PasswordHasher!
    private var userSessionRepository: UserSessionRepositorySpy!
    private var hasher: HashProtocol!
    private let testUsername = "restart"
    private let testPassword = "123456"
    
    override func setUp() {
        super.setUp()
        
        hasher = CryptoHasher(hash: .sha256, encoding: .hex)

        passwordHasher = PasswordHasher(
            hasher: hasher
        )
        
        userSessionRepository = UserSessionRepositorySpy()
        
        sut = AuthorizeUserTask(
            passwordHasher: passwordHasher,
            userSessionRepository: userSessionRepository
        )
    }
    
    override func tearDown() {
        hasher = nil
        passwordHasher = nil
        userSessionRepository = nil
        sut = nil
        super.tearDown()
    }
    
    func testShould_throw_if_credentials_are_wrong() {
        let request = AuthorizeUserRequest(
            userName: "invalidUsername",
            password: "invalidPassword"
        )
        
        XCTAssertThrowsError(try sut.execute(request)) { (error) in
            XCTAssertEqual(AuthorizationError.invalidCredentials, error as? AuthorizationError)
        }
    }
    
    func testShould_authorize_if_credentials_are_correct() {
        givenUser(
            with: testUsername,
            password: testPassword
        )
        
        let request = AuthorizeUserRequest(
            userName: testUsername,
            password: testPassword
        )
        
        XCTAssertNotNil(try! sut.execute(request))
    }
    
    func testShould_throw_if_password_is_incorect() {
        givenUser(
            with: testUsername,
            password: testPassword
        )
        
        let request = AuthorizeUserRequest(
            userName: testUsername,
            password: "invalidPassword"
        )
        
        XCTAssertThrowsError(try sut.execute(request)) { (error) in
            XCTAssertEqual(AuthorizationError.invalidCredentials, error as? AuthorizationError)
        }
    }
    
    func testShould_throw_if_user_is_disabled() {
        let user = givenDisabledUser(
            with: testUsername,
            password: testPassword
        )
        
        try! user.save()
        
        let request = AuthorizeUserRequest(
            userName: testUsername,
            password: testPassword
        )
        
        XCTAssertThrowsError(try sut.execute(request)) { (error) in
            XCTAssertEqual(AuthorizationError.disabledUser, error as? AuthorizationError)
        }
    }
    
    func testShould_store_user_session_in_cache() {
        givenUser(
            with: testUsername,
            password: testPassword
        )
        
        let request = AuthorizeUserRequest(
            userName: testUsername,
            password: testPassword
        )
        try! sut.execute(request)
        
        XCTAssertTrue(userSessionRepository.storeExecuted)
    }

    func testShould_throw_if_cannot_store_user_session_in_cache() {
        givenUser(
            with: testUsername,
            password: testPassword
        )
        
        let request = AuthorizeUserRequest(
            userName: testUsername,
            password: testPassword
        )
        userSessionRepository.storeShouldThrow = true
        
        XCTAssertThrowsError(try sut.execute(request)) { (error) in
            XCTAssertEqual(AuthorizationError.unknown, error as? AuthorizationError)
        }
    }
}
