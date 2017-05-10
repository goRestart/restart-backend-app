import Foundation

public protocol GameRepositoryProtocol {
    func getAllPlatforms() throws -> [Platform]
}
