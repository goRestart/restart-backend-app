import Foundation

protocol SessionDataSource {
    @discardableResult
    func store(_ request: AddSessionRequest) throws -> UserSession
}
