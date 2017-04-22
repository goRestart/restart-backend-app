import Foundation
import Domain

protocol SessionDataSource {
    @discardableResult
    func store(_ request: AddSessionRequest) throws -> UserSession
}
