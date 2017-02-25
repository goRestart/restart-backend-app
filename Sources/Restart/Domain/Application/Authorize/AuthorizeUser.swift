import Foundation

public struct AuthorizeUser {

    private let authService: AuthService

    init(authService: AuthService) {
        self.authService = authService
    }

    func authorize(_ request: AuthorizeUserRequest) throws {
        try authService.authorize(request)
    }
}
