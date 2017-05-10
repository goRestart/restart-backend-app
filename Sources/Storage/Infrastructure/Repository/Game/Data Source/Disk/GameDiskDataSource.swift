import Foundation
import Domain
import FluentStorage

struct GameDiskDataSource: GameDataSource {
    
    private let platformDiskModelToDomainMapper: PlatformDiskModelToDomainMapper
    
    init(platformDiskModelToDomainMapper: PlatformDiskModelToDomainMapper) {
        self.platformDiskModelToDomainMapper = platformDiskModelToDomainMapper
    }
    
    func getAllPlatforms() throws -> [Platform] {
        let platforms = try PlatformDiskModel.all()
        return platformDiskModelToDomainMapper.map(array: platforms)
    }
}
