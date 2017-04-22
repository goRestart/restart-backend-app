import Foundation
import Domain
import Shared

public struct AddUserTask {

    private let emailValidator: Shared.EmailValidator
    private let verifyFieldTask: VerifyFieldTask
    private let passwordHasher: PasswordHasher

    init(emailValidator: Shared.EmailValidator,
         verifyFieldTask: VerifyFieldTask,
         passwordHasher: PasswordHasher)
    {
        self.emailValidator = emailValidator
        self.verifyFieldTask = verifyFieldTask
        self.passwordHasher = passwordHasher
    }

    public func execute(_ request: AddUserRequest) throws {
        let email = request.email.lowercased()
        let userName = request.userName.lowercased() // TODO: Remove the lowercased
        let password = request.password

        // TODO: Add username validator 
        
        if !emailValidator.validate(email) {
            throw AddUserError.invalidEmail
        }
        
        try verifyFieldTask.execute(.username(userName))
        try verifyFieldTask.execute(.email(email))

        let hashedPassword = try passwordHasher.hash(
            userName: userName,
            password: password
        )
        
        let user = UserDiskModel(
            username: userName,
            password: hashedPassword
        )
        
        do {
            try user.save()
        } catch {
            throw AddUserError.unknown
        }
    }
}
