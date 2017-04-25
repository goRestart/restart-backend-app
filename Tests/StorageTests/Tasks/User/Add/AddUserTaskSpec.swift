import Foundation
import XCTest
import Vapor
import FluentProvider
import Domain
import Shared
@testable import Storage

class AddUserTaskSpec: XCTestDatabasePreparations {

//    static let allTests = [
//        ("testShould_throw_error_if_email_is_incorrect", testShould_throw_error_if_email_is_incorrect),
//        ("testShould_throw_error_if_username_is_duplicated", testShould_throw_error_if_username_is_duplicated),
//        ("testShould_throw_error_if_email_is_duplicated", testShould_throw_error_if_email_is_duplicated),
//        ("testShould_add_user_if_all_fields_are_valid", testShould_add_user_if_all_fields_are_valid)
//    ]

    private var sut: AddUserTask!
    private var emailValidator: EmailValidator!
    private var verifyFieldTask: VerifyFieldTask!
    private var passwordHasher: PasswordHasher!
    private let droplet = try! Droplet()

    private let testEmail = "hi@restart.net"
    private let invalidEmail = "hi@com"
    private let testUsername = "restart"

    override func setUp() {
        super.setUp()
        prepare(UserDiskModel.self)

        emailValidator = EmailValidator()
        verifyFieldTask = VerifyFieldTask()
        passwordHasher = PasswordHasher(
            hasher: droplet.hash
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

    func fixMetestShould_throw_error_if_email_is_incorrect() {
        let request = AddUserRequest(
            username: testUsername,
            email: invalidEmail,
            password: "ugbhnjdmkhgasd"
        )

        XCTAssertThrowsError(try sut.execute(request)) { error in
            XCTAssertEqual(error as? AddUserError, AddUserError.invalidEmail)
        }
    }

    func fixMetestShould_throw_error_if_username_is_duplicated() {
        XCTAssertThrowsError(try givenThereAreDuplicatedUsersWithSameUserName(2))

        let request = AddUserRequest(
            username: testUsername,
            email: testEmail,
            password: "c001d209a772r"
        )

        XCTAssertThrowsError(try sut.execute(request)) { error in
            XCTAssertEqual(error as? AddUserError, AddUserError.userNameIsAlreadyInUse)
        }
    }

    func fixMetestShould_throw_error_if_email_is_duplicated() {
        XCTAssertThrowsError(try givenThereAreDuplicatedUsersWithSameEmail(2))

        let request = AddUserRequest(
            username: testUsername,
            email: testEmail,
            password: "c001d209a772r"
        )
        
        XCTAssertThrowsError(try sut.execute(request)) { error in
            XCTAssertEqual(error as? AddUserError, AddUserError.emailIsAlreadyInUse)
        }
    }

    func fixMetestShould_add_user_if_all_fields_are_valid() {
        let request = AddUserRequest(
            username: testUsername,
            email: testEmail,
            password: "c001d209a772r"
        )
        try! sut.execute(request)

        let count = try! UserDiskModel.makeQuery().all().count

        XCTAssertEqual(1, count)
    }

    // MARK: - Helpers

    private func givenThereAreDuplicatedUsersWithSameUserName(_ amount: Int) throws {
        for _ in 0...amount {
            try generateWithSameUserName()
        }
    }

    private func givenThereAreDuplicatedUsersWithSameEmail(_ amount: Int) throws {
        for _ in 0...amount {
            try generateWithSameEmail()
        }
    }

    private func generateWithSameUserName() throws {
        let password = PasswordDiskModel(
            hash: "hash",
            salt: "salt"
        )
        try password.save()

        let user = UserDiskModel(
            username: testUsername,
            passwordId: password.id!
        )
        user.username = testUsername
        try user.save()
    }

    private func generateWithSameEmail() throws {
        let password = PasswordDiskModel(
            hash: "hash",
            salt: "salt"
        )
        try password.save()
        
        let user = UserDiskModel(
            username: testUsername,
            passwordId: password.id!
        )
        user.email = testEmail
        try user.save()
    }
}
