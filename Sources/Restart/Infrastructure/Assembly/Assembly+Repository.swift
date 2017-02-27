import ServiceLocator

// MARK: - Session 

extension Assembly {

    func getUserSessionRepository() -> SessionRepository {
        return SessionRepository(
            diskSessionDataSource: getDiskSessionDataSource()
        )
    }

    func getDiskSessionDataSource() -> SessionDataSource {
        return SessionDiskDataSource(
            userSessionDiskModelToDomainMapper: getUserSessionDiskModelToDomainMapper()
        )
    }
}
