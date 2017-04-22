import ServiceLocator

extension Assembly {

    func getUserSessionDiskModelToDomainMapper() -> UserSessionDiskModelToDomainMapper {
        return UserSessionDiskModelToDomainMapper()
    }
}
