import Foundation

public enum AddUserError: Error {
    case userNameIsAlreadyInUse
    case emailIsAlreadyInUse
    case invalidEmail
    case unknown
}

public protocol UserRepositoryProtocol {
    func add(with request: AddUserRequest) throws -> User
}
