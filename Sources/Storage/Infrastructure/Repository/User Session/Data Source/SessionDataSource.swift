import Foundation
import Domain

protocol UserSessionDataSource {
    @discardableResult
    func store(_ request: AddSessionRequest) throws -> UserSession
}
