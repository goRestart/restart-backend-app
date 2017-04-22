import Foundation
import Domain

public struct UserSessionRepository: UserSessionRepositoryProtocol {

    private let userSessionDataSourceProvider: UserSessionDataSourceProvider
    private let diskUserSessionDataSource: UserSessionDataSource

    init(userSessionDataSourceProvider: UserSessionDataSourceProvider,
         diskUserSessionDataSource: UserSessionDataSource)
    {
        self.userSessionDataSourceProvider = userSessionDataSourceProvider
        self.diskUserSessionDataSource = diskUserSessionDataSource
    }

    @discardableResult
    public func store(_ request: AddSessionRequest) throws -> UserSession {
        do {
            try userSessionDataSourceProvider.inMemory().store(request)
        } catch {}
        return try diskUserSessionDataSource.store(request)
    }
}
