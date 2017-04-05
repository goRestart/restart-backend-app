import Foundation
import XCTest
import FluentProvider

@testable import Restart

class VerifyFieldTaskSpec: XCTestDatabasePreparations {

    static let allTests = [
        ("testShould_throw_when_username_is_duplicated", testShould_throw_when_username_is_duplicated),
        ("testShould_throw_when_email_is_duplicated", testShould_throw_when_email_is_duplicated)
    ]

    private var sut: VerifyFieldTask!

    private let testEmail = "hi@restart.net"
    private let testUserName = "restart"

    override func setUp() {
        super.setUp()
        prepare(UserDiskModel.self)
        sut = VerifyFieldTask()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func testShould_throw_when_username_is_duplicated() {
        XCTAssertThrowsError(try givenThereAreDuplicatedUsers(2))

        XCTAssertThrowsError(try sut.execute(.username(testUserName))) { error in
            XCTAssertEqual(error as? AddUserError, AddUserError.userNameIsAlreadyInUse)
        }
    }

    func testShould_throw_when_email_is_duplicated() {
        XCTAssertThrowsError(try givenThereAreDuplicatedEmails(2))

        XCTAssertThrowsError(try sut.execute(.email(testEmail))) { error in
            XCTAssertEqual(error as? AddUserError, AddUserError.emailIsAlreadyInUse)
        }
    }

    // MARK: - Helpers

    private func givenThereAreDuplicatedUsers(_ amount: Int) throws {
        for _ in 0...amount {
            try generate()
        }
    }
    
    private func givenThereAreDuplicatedEmails(_ amount: Int) throws {
        for _ in 0...amount {
            try generate(email: testEmail)
        }
    }

    private func generate(email: String? = nil) throws {
        let user = UserDiskModel(
            username: testUserName,
            password: "c001d209a772r"
        )
        user.email = email
        try user.save()
    }
}
