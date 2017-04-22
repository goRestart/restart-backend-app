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
        let droplet = getDroplet()
        
        return InMemoryUserSessionDataSource(
            memoryCache: droplet.cache
        )
    }
    
    func getDiskSessionDataSource() -> UserSessionDataSource {
        return UserSessionDiskDataSource(
            userSessionDiskModelToDomainMapper: getUserSessionDiskModelToDomainMapper()
        )
    }
}
