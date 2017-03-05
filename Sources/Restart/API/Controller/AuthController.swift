import Vapor
import HTTP
import JSON

private struct AuthParameters {
    static let username = "username"
    static let password = "password"
}

public struct AuthController {

    private let authorizeUser: AuthorizeUser

    init(authorizeUser: AuthorizeUser) {
        self.authorizeUser = authorizeUser
    }

    func post(_ request: Request) throws -> ResponseRepresentable {
        guard let userName = request.data[AuthParameters.username]?.string,
              let password = request.data[AuthParameters.password]?.string else
        {
            throw MissingParameters.error
        }

        let authorizeUserRequest = AuthorizeUserRequest(
            userName: userName,
            password: password
        )

        do {
            return JSON(try authorizeUser.authorize(authorizeUserRequest).makeNode())
        } catch AuthorizationError.invalidCredentials {
            throw InvalidCredentials.error
        } catch AuthorizationError.disabledUser {
            throw DisabledUser.error
        } catch {
            throw ServerError.error
        }
    }
}
