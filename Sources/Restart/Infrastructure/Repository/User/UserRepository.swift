import Foundation

public struct UserRepository: UserRepositoryProtocol {

    private let diskDataSource: UserDataSource

    public init(diskDataSource: UserDataSource) {
        self.diskDataSource = diskDataSource
    }

    public func add(with request: AddUserRequest) throws -> User {
        return try diskDataSource.add(with: request)
    }
}
