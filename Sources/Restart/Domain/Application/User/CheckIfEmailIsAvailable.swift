import Foundation

public struct CheckIfEmailIsAvailable {

    private let userService: UserService

    public init(userService: UserService) {
        self.userService = userService
    }

    func isAvailable(_ email: String) -> Bool {
        do {
            try userService.verify(.email(email))
        } catch {
            return false
        }
        return true
    }
}
