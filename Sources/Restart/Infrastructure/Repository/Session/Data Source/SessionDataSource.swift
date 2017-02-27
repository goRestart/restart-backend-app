import Foundation

protocol SessionDataSource {
    func store(_ request: AddSessionRequest) throws -> UserSession
}
