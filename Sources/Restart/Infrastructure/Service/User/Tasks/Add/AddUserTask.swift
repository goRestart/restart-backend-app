import Foundation

public struct AddUserTask {

    private let emailValidator: EmailValidator
    private let passwordHasher: PasswordHasher

    init(emailValidator: EmailValidator,
         passwordHasher: PasswordHasher)
    {
        self.emailValidator = emailValidator
        self.passwordHasher = passwordHasher
    }

    func execute(_ request: AddUserRequest) throws -> User {
        let email = request.email.lowercased()
        let userName = request.userName.lowercased()
        let password = request.password.lowercased()

        if !emailValidator.validate(input: email) {
            throw AddUserError.invalidEmail
        }

        if let _ = try UserDiskModel.query().filter(UserDiskModel.Field.username, userName).first() {
            throw AddUserError.userNameIsAlreadyInUse
        }

        if let _ = try UserDiskModel.query().filter(UserDiskModel.Field.email, email).first() {
            throw AddUserError.emailIsAlreadyInUse
        }

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

        return User(
            identifier: user.id!.string!,
            userName: userName,
            firstName: nil,
            lastName: nil,
            description: nil,
            profileImage: nil,
            email: email,
            location: nil,
            status: .Enabled,
            locale: nil,
            applicationVersion: nil,
            birtdate: nil,
            createdAt: Date(),
            updatedAt: Date()
        )
    }
}
