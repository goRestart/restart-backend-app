import Foundation
import Domain

public struct AddUser {

    private let userService: UserService

    public init(userService: UserService) {
        self.userService = userService
    }

    public func add(with request: AddUserRequest) throws {
        return try userService.add(request)
    }
}
