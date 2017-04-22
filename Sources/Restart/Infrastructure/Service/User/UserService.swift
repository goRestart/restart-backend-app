import Storage
import Domain

public struct UserService {
    
    private let verifyFieldTask: VerifyFieldTask
    private let addUserTask: AddUserTask

    public init(verifyFieldTask: VerifyFieldTask,
                addUserTask: AddUserTask)
    {
        self.verifyFieldTask = verifyFieldTask
        self.addUserTask = addUserTask
    }

    func add(_ request: AddUserRequest) throws {
        return try addUserTask.execute(request)
    }

    func verify(_ field: FieldToVerify) throws {
        try verifyFieldTask.execute(field)
    }
}
