import Foundation

struct SessionDiskDataSource: SessionDataSource {

    private let userSessionDiskModelToDomainMapper: UserSessionDiskModelToDomainMapper

    init(userSessionDiskModelToDomainMapper: UserSessionDiskModelToDomainMapper) {
        self.userSessionDiskModelToDomainMapper = userSessionDiskModelToDomainMapper
    }

    @discardableResult
    func store(_ request: AddSessionRequest) throws -> UserSession {
        var userSession = UserSessionDiskModel(
            token: Identifier.make().value,
            userId: request.userId,
            validUntil: Date().addingTimeInterval(request.validityInterval)
        )
        try userSession.save()

        return userSessionDiskModelToDomainMapper.map(userSession)
    }
}
