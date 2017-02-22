import Foundation

struct UserService {

    private let addUserTask: AdduserTask

    init(addUserTask: AdduserTask) {
        self.addUserTask = addUserTask
    }

    func add(_ request: AddUserRequest) throws {
        try addUserTask.execute(request)
    }
}
