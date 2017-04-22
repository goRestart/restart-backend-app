import Foundation
import Domain
@testable import Storage

enum SessionDataError: Error {
    case unknown
}

final class UserSessionDataSourceMock: UserSessionDataSource {

    var errorToThrow: Error?
    var storeExecuted = false

    func store(_ request: AddSessionRequest) throws -> UserSession {
        storeExecuted = true
        if let errorToThrow = errorToThrow {
            throw errorToThrow
        }
        return UserSession(
            token: UUID().uuidString,
            validUntil: Date()
        )
    }
}
