import Foundation

public struct AddUser {

    private let userService: UserService

    public init(userService: UserService) {
        self.userService = userService
    }

    func add(with request: AddUserRequest) throws {
        return try userService.add(request)
    }
}
