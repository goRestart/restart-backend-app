import Vapor
import HTTP
import JSON

private struct Params {
    static let username = "username"
    static let password = "password"
    static let email = "email"
}

public struct UserController {

    private let addUser: AddUser

    init(addUser: AddUser) {
        self.addUser = addUser
    }

    func post(_ request: Request) throws -> ResponseRepresentable {
        guard let userName = request.data[Params.username]?.string,
              let email = request.data[Params.email]?.string,
              let password = request.data[Params.password]?.string else
        {
            throw MissingParameters.error
        }

        let request = AddUserRequest(
            userName: userName,
            email: email,
            password: password
        )

        do {
            try addUser.add(with: request)
        } catch AddUserError.userNameIsAlreadyInUse {
            throw UserNameIsAlreadyInUse.error
        } catch AddUserError.emailIsAlreadyInUse {
            throw EmailIsAlreadyInUse.error
        } catch AddUserError.invalidEmail {
            throw InvalidEmail.error
        } catch {
            throw ServerError.error
        }

        return try Response(status: .created, json: JSON("ok"))
    }
}
