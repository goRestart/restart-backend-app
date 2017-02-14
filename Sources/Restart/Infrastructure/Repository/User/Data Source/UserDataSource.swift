import Foundation

public protocol UserDataSource {
    func add(with request: AddUserRequest) throws -> User
}
