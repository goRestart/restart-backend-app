@testable import Restart

import Foundation

enum SessionDataError: Error {
    case unknown
}

final class SessionDataSourceMock: SessionDataSource {

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
