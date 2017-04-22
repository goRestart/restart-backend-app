import ServiceLocator

// MARK: - Session

extension Assembly: SessionDataSourceProvider {
    
    func getUserSessionRepository() -> UserSessionRepository {
        return UserSessionRepository(
            sessionDataSourceProvider: self,
            diskSessionDataSource: getDiskSessionDataSource()
        )
    }
    
    func inMemory() -> SessionDataSource {
        let droplet = getDroplet()
        
        return InMemorySessionDataSource(
            memoryCache: droplet.cache
        )
    }
    
    func getDiskSessionDataSource() -> SessionDataSource {
        return SessionDiskDataSource(
            userSessionDiskModelToDomainMapper: getUserSessionDiskModelToDomainMapper()
        )
    }
}
