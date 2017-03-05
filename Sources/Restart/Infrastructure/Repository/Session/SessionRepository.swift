import Foundation

public struct SessionRepository: SessionRepositoryProtocol {

    private let inMemorySessionDataSource: SessionDataSource
    private let diskSessionDataSource: SessionDataSource

    init(inMemorySessionDataSource: SessionDataSource,
         diskSessionDataSource: SessionDataSource)
    {
        self.inMemorySessionDataSource = inMemorySessionDataSource
        self.diskSessionDataSource = diskSessionDataSource
    }

    @discardableResult
    public func store(_ request: AddSessionRequest) throws -> UserSession {
        do {
            try inMemorySessionDataSource.store(request)
        } catch {}
        return try diskSessionDataSource.store(request)
    }
}
