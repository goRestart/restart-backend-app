import Foundation

public struct UserService {

    private let addUserTask: AddUserTask

    public init(addUserTask: AddUserTask) {
        self.addUserTask = addUserTask
    }

    func add(_ request: AddUserRequest) throws -> User {
        return try addUserTask.execute(request)
    }
}
