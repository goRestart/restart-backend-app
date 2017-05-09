import Foundation
import Domain
import Shared
import FluentStorage

public struct AddUserTask {

    private let emailValidator: EmailValidator
    private let verifyFieldTask: VerifyFieldTask

    init(emailValidator: EmailValidator,
         verifyFieldTask: VerifyFieldTask)
    {
        self.emailValidator = emailValidator
        self.verifyFieldTask = verifyFieldTask
    }

    public func execute(_ request: AddUserRequest) throws {
        let email = request.email.lowercased()
        let username = request.username
        let password = request.password

        // TODO: Add username validator 
        
        if !emailValidator.validate(email) {
            throw AddUserError.invalidEmail
        }
        
        try verifyFieldTask.execute(.username(username))
        try verifyFieldTask.execute(.email(email))

        let user = try UserDiskModel(
            username: username,
            password: password
        )
        user.email = email
        
        do {
            try user.save()
        } catch {
            throw AddUserError.unknown
        }
    }
}
