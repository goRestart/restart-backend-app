import ServiceLocator
import Domain

// MARK: - Session

extension Assembly: UserSessionDataSourceProvider {
    
    func getUserSessionRepository() -> UserSessionRepositoryProtocol {
        return UserSessionRepository(
            userSessionDataSourceProvider: self,
            diskUserSessionDataSource: getDiskSessionDataSource()
        )
    }
    
    func inMemory() -> UserSessionDataSource {
        return InMemoryUserSessionDataSource(
            memoryCache: getMemoryCache()
        )
    }
    
    private func getDiskSessionDataSource() -> UserSessionDataSource {
        return UserSessionDiskDataSource(
            userSessionDiskModelToDomainMapper: getUserSessionDiskModelToDomainMapper()
        )
    }
}


// MARK: - Game

extension Assembly {
    
    public func getGameRepository() -> GameRepositoryProtocol {
        return GameRepository(
            diskDataSource: getGameDiskDataSource()
        )
    }
    
    private func getGameDiskDataSource() -> GameDataSource {
        return GameDiskDataSource(
            platformDiskModelToDomainMapper: getPlatformDiskModelToDomainMapper()
        )
    }
}
