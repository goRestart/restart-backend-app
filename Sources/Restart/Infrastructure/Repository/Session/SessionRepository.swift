import Foundation

public struct SessionRepository {

    private let diskSessionDataSource: SessionDataSource

    init(diskSessionDataSource: SessionDataSource) {
        self.diskSessionDataSource = diskSessionDataSource
    }

    func store(_ request: AddSessionRequest) throws -> UserSession {
        return try diskSessionDataSource.store(request)
    }
}
