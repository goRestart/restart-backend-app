import Foundation

public struct SessionRepository {

    private let inMemorySessionDataSource: SessionDataSource
    private let diskSessionDataSource: SessionDataSource

    init(inMemorySessionDataSource: SessionDataSource,
         diskSessionDataSource: SessionDataSource)
    {
        self.inMemorySessionDataSource = inMemorySessionDataSource
        self.diskSessionDataSource = diskSessionDataSource
    }

    func store(_ request: AddSessionRequest) throws -> UserSession {
        try inMemorySessionDataSource.store(request)
        return try diskSessionDataSource.store(request)
    }
}
