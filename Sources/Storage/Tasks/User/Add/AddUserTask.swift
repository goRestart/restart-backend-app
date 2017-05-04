import Foundation
import Domain
import Shared

public struct AddUserTask {

    private let emailValidator: EmailValidator
    private let verifyFieldTask: VerifyFieldTask
    private let passwordHasher: PasswordHasher

    init(emailValidator: EmailValidator,
         verifyFieldTask: VerifyFieldTask,
         passwordHasher: PasswordHasher)
    {
        self.emailValidator = emailValidator
        self.verifyFieldTask = verifyFieldTask
        self.passwordHasher = passwordHasher
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
