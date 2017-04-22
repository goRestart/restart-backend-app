import Foundation
import Domain

struct SessionDiskDataSource: SessionDataSource {

    private let userSessionDiskModelToDomainMapper: UserSessionDiskModelToDomainMapper

    init(userSessionDiskModelToDomainMapper: UserSessionDiskModelToDomainMapper) {
        self.userSessionDiskModelToDomainMapper = userSessionDiskModelToDomainMapper
    }

    @discardableResult
    func store(_ request: AddSessionRequest) throws -> UserSession {
        let token = UUID().uuidString
        let validUntil = Date().addingTimeInterval(request.validityInterval)
        
        let userSession = UserSessionDiskModel(
            token: token,
            userId: request.userId,
            validUntil: validUntil
        )
        try userSession.save()

        return userSessionDiskModelToDomainMapper.map(userSession)
    }
}
