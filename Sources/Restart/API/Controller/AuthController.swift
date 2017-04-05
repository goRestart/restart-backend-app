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
            return MissingParameters.error
        }

        let authorizeUserRequest = AuthorizeUserRequest(
            userName: userName,
            password: password
        )

        do {
            return try JSON(node: authorizeUser.authorize(authorizeUserRequest))
        } catch AuthorizationError.invalidCredentials {
            return InvalidCredentials.error
        } catch AuthorizationError.disabledUser {
            return DisabledUser.error
        } catch {
            return ServerError.error
        }
    }
}
