import Foundation
import Domain

final class UserSessionRepositorySpy: UserSessionRepositoryProtocol {

    var storeExecuted = false
    var storeShouldThrow = false
    
    func store(_ request: AddSessionRequest) throws -> UserSession {
        storeExecuted = true
        
        if storeShouldThrow {
            throw AuthorizationError.disabledUser
        }
        
        return UserSession(
            token: "💾",
            validUntil: Date()
        )
    }
}
