import ServiceLocator

extension Assembly {

    func getUserSessionDiskModelToDomainMapper() -> UserSessionDiskModelToDomainMapper {
        return UserSessionDiskModelToDomainMapper()
    }
    
    func getPlatformDiskModelToDomainMapper() -> PlatformDiskModelToDomainMapper {
        return PlatformDiskModelToDomainMapper()
    }
}
