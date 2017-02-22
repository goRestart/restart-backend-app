import Foundation

struct AdduserTask {

    private let emailValidator: EmailValidator
    private let passwordHasher: PasswordHasher

    init(emailValidator: EmailValidator,
         passwordHasher: PasswordHasher)
    {
        self.emailValidator = emailValidator
        self.passwordHasher = passwordHasher
    }

    func execute(_ request: AddUserRequest) throws -> User {
        if !emailValidator.validate(input: request.email) {
            throw AddUserError.invalidEmail
        }

        if let _ = try UserDiskModel.query().filter(UserDiskModel.Field.username, request.userName).first() {
            throw AddUserError.userNameIsAlreadyInUse
        }

        if let _ = try UserDiskModel.query().filter(UserDiskModel.Field.email, request.email).first() {
            throw AddUserError.emailIsAlreadyInUse
        }

        let password = passwordHasher.hash(
            userName: request.userName,
            password: request.password
        )

        var user = UserDiskModel(
            id: Identifier.make().value,
            username: request.userName,
            email: request.email,
            password: password
        )

        do {
            try user.save()
        } catch {
            throw AddUserError.unknown
        }

        return User(
            identifier: user.id!.string!,
            userName: request.userName,
            firstName: nil,
            lastName: nil,
            description: nil,
            profileImage: nil,
            email: request.email,
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
