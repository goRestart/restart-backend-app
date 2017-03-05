import Foundation

public protocol SessionRepositoryProtocol {
    @discardableResult
    func store(_ request: AddSessionRequest) throws -> UserSession
}
