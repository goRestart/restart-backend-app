import Foundation

public protocol UserRepositoryProtocol {
    func add(with request: AddUserRequest) throws -> User
}
