import Foundation
import Domain
import FluentStorage

private let oneDay = 60 * 60 * 24
private let numberOfDaysInYear = 365
private let onYear = numberOfDaysInYear * oneDay
private let sessionAuthorizationInterval = TimeInterval(onYear * 2)

public struct AuthorizeUserTask {

    private let userSessionRepository: UserSessionRepositoryProtocol

    init(userSessionRepository: UserSessionRepositoryProtocol) {
        self.userSessionRepository = userSessionRepository
    }

    @discardableResult
    public func execute(_ request: AuthorizeUserRequest) throws -> UserSession {
        let username = request.userName
        let password = request.password

        guard let user = try UserDiskModel.makeQuery()
            .filter(raw: "\(UserDiskModel.Field.username) = ('\(username)')")
            .first() else {
                throw AuthorizationError.invalidCredentials
        }
        
        let passwordMatches = try user.check(
            username: username,
            password: password
        )
        
        if !passwordMatches {
            throw AuthorizationError.invalidCredentials
        }
        
        let usernameIsEnabled = user.status == .enabled
        if !usernameIsEnabled {
            throw AuthorizationError.disabledUser
        }

        let sessionRequest = AddSessionRequest(
            userId: user.id!.string!,
            validityInterval: sessionAuthorizationInterval
        )
        return try userSessionRepository.store(sessionRequest)
    }
}
