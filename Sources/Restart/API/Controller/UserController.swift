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
    private let checkIfEmailIsAvailable: CheckIfEmailIsAvailable
    private let addUser: AddUser

    init(checkIfUserNameIsAvailable: CheckIfUserNameIsAvailable,
         checkIfEmailIsAvailable: CheckIfEmailIsAvailable,
         addUser: AddUser)
    {
        self.checkIfUserNameIsAvailable = checkIfUserNameIsAvailable
        self.checkIfEmailIsAvailable = checkIfEmailIsAvailable
        self.addUser = addUser
    }

    func post(_ request: Request) throws -> ResponseRepresentable {
        guard let userName = request.data[UserParameters.username]?.string,
              let email = request.data[UserParameters.email]?.string,
              let password = request.data[UserParameters.password]?.string else
        {
            return MissingParameters.error
        }

        let request = AddUserRequest(
            userName: userName,
            email: email,
            password: password
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

    func verify(_ request: Request) throws -> ResponseRepresentable {
        if let userName = request.data[UserParameters.username]?.string {
            if !checkIfUserNameIsAvailable.isAvailable(userName) {
                return UserNameIsAlreadyInUse.error
            }
            return AvailableUsername.response
        }

        if let email = request.data[UserParameters.email]?.string {
            if !checkIfEmailIsAvailable.isAvailable(email) {
                return EmailIsAlreadyInUse.error
            }
            return AvailableEmail.response
        }

        return MissingParameters.error
    }
}
