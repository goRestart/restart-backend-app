import Foundation

public struct CheckIfUserNameIsAvailable {

    private let userService: UserService

    public init(userService: UserService) {
        self.userService = userService
    }
    
    func isAvailable(_ username: String) -> Bool {
        do {
            try userService.verify(.username(username))
        } catch {
            return false
        }
        return true
    }
}
