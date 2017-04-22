import Foundation
import Domain

struct UserSessionRepositoryDummy: UserSessionRepositoryProtocol {

    func store(_ request: AddSessionRequest) throws -> UserSession {
        return UserSession(
            token: "💾",
            validUntil: Date()
        )
    }
}
