import Foundation

public struct AuthService {

    private let authorizeUserTask: AuthorizeUserTask

    init(authorizeUserTask: AuthorizeUserTask) {
        self.authorizeUserTask = authorizeUserTask
    }

    func authorize(_ request: AuthorizeUserRequest) throws -> UserSession {
        return try authorizeUserTask.execute(request)
    }
}
