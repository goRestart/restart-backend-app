import ServiceLocator

// MARK: - Session 

extension Assembly {

    func getUserSessionRepository() -> SessionRepository {
        return SessionRepository(
            inMemorySessionDataSource: getInMemorySessionDataSource(),
            diskSessionDataSource: getDiskSessionDataSource()
        )
    }

    func getInMemorySessionDataSource() -> SessionDataSource {
        let droplet = getDroplet()
        return InMemorySessionDataSource(
            redisCache: droplet.cache
        )
    }

    func getDiskSessionDataSource() -> SessionDataSource {
        return SessionDiskDataSource(
            userSessionDiskModelToDomainMapper: getUserSessionDiskModelToDomainMapper()
        )
    }
}
