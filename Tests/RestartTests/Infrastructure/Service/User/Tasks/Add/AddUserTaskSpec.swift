import Foundation
import XCTest
import Vapor
@testable import Restart

class AddUserTaskSpec: XCTestDatabasePreparations {

    static let allTests = [
        ("testShould_throw_error_if_email_is_incorrect", testShould_throw_error_if_email_is_incorrect),
        ("testShould_throw_error_if_username_is_duplicated", testShould_throw_error_if_username_is_duplicated),
        ("testShould_throw_error_if_email_is_duplicated", testShould_throw_error_if_email_is_duplicated),
        ("testShould_add_user_if_all_fields_are_valid", testShould_add_user_if_all_fields_are_valid)
    ]

    private var sut: AddUserTask!
    private var emailValidator: EmailValidator!
    private var verifyFieldTask: VerifyFieldTask!
    private var passwordHasher: PasswordHasher!
    private let droplet = Droplet()

    private let testEmail = "hi@restart.net"
    private let invalidEmail = "hi@com"
    private let testUserName = "restart"

    override func setUp() {
        super.setUp()
        prepare(UserDiskModel.self)

        emailValidator = EmailValidator()
        verifyFieldTask = VerifyFieldTask()
        passwordHasher = PasswordHasher(
            droplet: droplet
        )

        sut = AddUserTask(
            emailValidator: emailValidator,
            verifyFieldTask: verifyFieldTask,
            passwordHasher: passwordHasher
        )
    }

    override func tearDown() {
        emailValidator = nil
        verifyFieldTask = nil
        verifyFieldTask = nil
        sut = nil
        super.tearDown()
    }

    func testShould_throw_error_if_email_is_incorrect() {
        let request = AddUserRequest(
            userName: testUserName,
            email: invalidEmail,
            password: "ugbhnjdmkhgasd"
        )

        XCTAssertThrowsError(try sut.execute(request)) { error in
            XCTAssertEqual(error as? AddUserError, AddUserError.invalidEmail)
        }
    }

    func testShould_throw_error_if_username_is_duplicated() {
        givenThereAreDuplicatedUsersWithSameUserName(2)

        let request = AddUserRequest(
            userName: testUserName,
            email: testEmail,
            password: "c001d209a772r"
        )

        XCTAssertThrowsError(try sut.execute(request)) { error in
            XCTAssertEqual(error as? AddUserError, AddUserError.userNameIsAlreadyInUse)
        }
    }

    func testShould_throw_error_if_email_is_duplicated() {
        givenThereAreDuplicatedUsersWithSameEmail(2)

        let request = AddUserRequest(
            userName: testUserName,
            email: testEmail,
            password: "c001d209a772r"
        )

        XCTAssertThrowsError(try sut.execute(request)) { error in
            XCTAssertEqual(error as? AddUserError, AddUserError.emailIsAlreadyInUse)
        }
    }

    func testShould_add_user_if_all_fields_are_valid() {
        let request = AddUserRequest(
            userName: testUserName,
            email: testEmail,
            password: "c001d209a772r"
        )
        try! sut.execute(request)

        let count = try! UserDiskModel.query().all().count

        XCTAssertEqual(1, count)
    }

    // MARK: - Helpers

    private func givenThereAreDuplicatedUsersWithSameUserName(_ amount: Int) {
        for _ in 0...amount {
            generateWithSameUserName()
        }
    }

    private func givenThereAreDuplicatedUsersWithSameEmail(_ amount: Int) {
        for _ in 0...amount {
            generateWithSameEmail()
        }
    }

    private func generateWithSameUserName() {
        var user = UserDiskModel(
            id: UUID().uuidString,
            username: testUserName,
            email: "\(UUID().uuidString)@restart.net",
            password: "c001d209a772r"
        )
        try! user.save()
    }

    private func generateWithSameEmail() {
        var user = UserDiskModel(
            id: UUID().uuidString,
            username: UUID().uuidString,
            email: testEmail,
            password: "c001d209a772r"
        )
        try! user.save()
    }
}