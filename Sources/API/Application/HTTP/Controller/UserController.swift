import HTTP
import Restart
import Domain

private struct UserParameters {
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
        guard let username = request.data[UserParameters.username]?.string,
              let email = request.data[UserParameters.email]?.string,
              let password = request.data[UserParameters.password]?.string else
        {
            return MissingParameters.error
        }

        let request = AddUserRequest(
            username: username,
            password: password,
            email: email
        )

        do {
            try addUser.add(with: request)
        } catch AddUserError.userNameIsAlreadyInUse {
            return UserNameIsAlreadyInUse.error
        } catch AddUserError.emailIsAlreadyInUse {
            return EmailIsAlreadyInUse.error
        } catch AddUserError.invalidEmail {
            return InvalidEmail.error
        } catch {
            return ServerError.error
        }

        return SuccessfullyCreated.response
    }
}
