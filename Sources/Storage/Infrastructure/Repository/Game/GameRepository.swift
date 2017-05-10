import Foundation
import Domain

public struct GameRepository: GameRepositoryProtocol {
    
    private let diskDataSource: GameDataSource
    
    init(diskDataSource: GameDataSource) {
        self.diskDataSource = diskDataSource
    }
    
    public func getAllPlatforms() throws -> [Platform] {
        return try diskDataSource.getAllPlatforms()
    }
}
