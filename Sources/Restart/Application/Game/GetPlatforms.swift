import Foundation
import Domain

public struct GetPlatforms {
    
    private let gameRepository: GameRepositoryProtocol
    
    init(gameRepository: GameRepositoryProtocol) {
        self.gameRepository = gameRepository
    }
    
    public func getAll() throws -> [Platform] {
        return try gameRepository.getAllPlatforms()
    }
}
