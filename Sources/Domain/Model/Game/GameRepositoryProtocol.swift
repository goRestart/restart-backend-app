import Foundation

protocol GameRepositoryProtocol {
    func getAllPlatforms() throws -> [Platform]
}
