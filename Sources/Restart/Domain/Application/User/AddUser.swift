import Foundation

public struct AddUser {

    private let userService: UserService

    public init(userService: UserService) {
        self.userService = userService
    }

    @discardableResult
    func add(with request: AddUserRequest) throws -> User {
        return try userService.add(request)
    }
}
