import Foundation

public struct AddUser {

    private let userRepository: UserRepositoryProtocol

    public init(userRepository: UserRepositoryProtocol) {
        self.userRepository = userRepository
    }

    @discardableResult
    func add(with request: AddUserRequest) throws -> User {
        return try userRepository.add(with: request)
    }
}
