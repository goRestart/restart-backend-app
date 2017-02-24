import Vapor
import HTTP
import JSON

private struct UserParameters {
    static let username = "username"
    static let password = "password"
    static let email = "email"
}

public struct UserController {

    private let checkIfUserNameIsAvailable: CheckIfUserNameIsAvailable
    private let addUser: AddUser

    init(checkIfUserNameIsAvailable: CheckIfUserNameIsAvailable,
         addUser: AddUser)
    {
        self.checkIfUserNameIsAvailable = checkIfUserNameIsAvailable
        self.addUser = addUser
    }

    func post(_ request: Request) throws -> ResponseRepresentable {
        guard let userName = request.data[UserParameters.username]?.string,
              let email = request.data[UserParameters.email]?.string,
              let password = request.data[UserParameters.password]?.string else
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

        return SuccessfullyCreated.response
    }

    func verify(_ request: Request) throws -> ResponseRepresentable {
        if let userName = request.data[UserParameters.username]?.string {
            if !checkIfUserNameIsAvailable.isAvailable(userName) {
                throw UserNameIsAlreadyInUse.error
            }
            return AvailableUsername.response
        }

        throw MissingParameters.error
    }
}
