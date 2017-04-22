import Foundation

public protocol UserSessionRepositoryProtocol {
    @discardableResult
    func store(_ request: AddSessionRequest) throws -> UserSession
}
