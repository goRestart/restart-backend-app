import Foundation
@testable import Restart

struct SessionRepositoryDummy: SessionRepositoryProtocol {

    func store(_ request: AddSessionRequest) throws -> UserSession {
        return UserSession(
            token: "💾",
            validUntil: Date()
        )
    }
}
