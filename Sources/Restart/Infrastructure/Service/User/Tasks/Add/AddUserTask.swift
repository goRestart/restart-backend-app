import Foundation

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

    func execute(_ request: AddUserRequest) throws {
        let email = request.email.lowercased()
        let userName = request.userName.lowercased()
        let password = request.password.lowercased()

        if !emailValidator.validate(email) {
            throw AddUserError.invalidEmail
        }

        try verifyFieldTask.execute(.username(userName))
        try verifyFieldTask.execute(.email(email))

        let hashedPassword = passwordHasher.hash(
            userName: userName,
            password: password
        )

        var user = UserDiskModel(
            id: Identifier.make().value,
            username: userName,
            email: email,
            password: hashedPassword
        )

        do {
            try user.save()
        } catch {
            throw AddUserError.unknown
        }
    }
}
