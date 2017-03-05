import Foundation

public struct AuthorizeUser {

    private let authService: AuthService

    init(authService: AuthService) {
        self.authService = authService
    }

    func authorize(_ request: AuthorizeUserRequest) throws -> UserSession {
        return try authService.authorize(request)
    }
}
