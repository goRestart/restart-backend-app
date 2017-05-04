import ServiceLocator

// MARK: - Session

extension Assembly: UserSessionDataSourceProvider {
    
    func getUserSessionRepository() -> UserSessionRepository {
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
    
    func getDiskSessionDataSource() -> UserSessionDataSource {
        return UserSessionDiskDataSource(
            userSessionDiskModelToDomainMapper: getUserSessionDiskModelToDomainMapper()
        )
    }
}
