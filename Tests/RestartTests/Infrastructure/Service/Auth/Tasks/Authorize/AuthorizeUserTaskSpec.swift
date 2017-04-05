import Foundation
import XCTest
import Vapor
@testable import Restart

class AuthorizeUserTaskSpec: XCTestDatabasePreparations {

    static let allTests = [
        ("testShould_throw_if_credentials_are_incorrect", testShould_throw_if_credentials_are_incorrect),
        ("testShould_throw_if_user_is_disabled", testShould_throw_if_user_is_disabled),
        ("testShould_authorize_if_credentials_are_correct", testShould_authorize_if_credentials_are_correct)
    ]

    private var sut: AuthorizeUserTask!
    private var passwordHasher: PasswordHasher!
    private var sessionRepository: SessionRepositoryDummy!
    private let droplet = try! Droplet()

    private let testEmail = "hi@restart.net"
    private let testUserName = "restart"
    private let testPassword = "mySuperMegaHackerPassword"

    override func setUp() {
        super.setUp()
        prepare(UserDiskModel.self)

        passwordHasher = PasswordHasher(
            hasher: droplet.hash
        )
        
        sessionRepository = SessionRepositoryDummy()

        sut = AuthorizeUserTask(
            passwordHasher: passwordHasher,
            sessionRepository: sessionRepository
        )
    }
    
    override func tearDown() {
        passwordHasher = nil
        sut = nil
        super.tearDown()
    }

    func testShould_throw_if_credentials_are_incorrect() {
        givenThereAreUsers()

        let request = AuthorizeUserRequest(
            userName: "restart",
            password: "Y2FsbCBtZSBtYXliZT8="
        )

        XCTAssertThrowsError(try sut.execute(request)) { error in
            XCTAssertEqual(error as? AuthorizationError, AuthorizationError.invalidCredentials)
        }
    }

    func testShould_throw_if_user_is_disabled() {
        givenThereAreUsers(enabled: false)

        let request = AuthorizeUserRequest(
            userName: testUserName,
            password: testPassword
        )

        XCTAssertThrowsError(try sut.execute(request)) { error in
            XCTAssertEqual(error as? AuthorizationError, AuthorizationError.disabledUser)
        }
    }

    func testShould_authorize_if_credentials_are_correct() {
        givenThereAreUsers()

        let request = AuthorizeUserRequest(
            userName: testUserName,
            password: testPassword
        )

        try! sut.execute(request)
    }

    // MARK - Helper

    private func givenThereAreUsers(enabled: Bool = true) {
        let hashedPassword = passwordHasher.hash(
            userName: testUserName,
            password: testPassword
        )

        let user = UserDiskModel(
            username: testUserName,
            password: hashedPassword
        )
        user.status = enabled ? .enabled: .blocked
        
        try! user.save()
    }
}
