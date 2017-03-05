import Foundation

public struct SessionRepository: SessionRepositoryProtocol {

    private let sessionDataSourceProvider: SessionDataSourceProvider
    private let diskSessionDataSource: SessionDataSource

    init(sessionDataSourceProvider: SessionDataSourceProvider,
         diskSessionDataSource: SessionDataSource)
    {
        self.sessionDataSourceProvider = sessionDataSourceProvider
        self.diskSessionDataSource = diskSessionDataSource
    }

    @discardableResult
    public func store(_ request: AddSessionRequest) throws -> UserSession {
        do {
            try sessionDataSourceProvider.inMemory().store(request)
        } catch {}
        return try diskSessionDataSource.store(request)
    }
}
