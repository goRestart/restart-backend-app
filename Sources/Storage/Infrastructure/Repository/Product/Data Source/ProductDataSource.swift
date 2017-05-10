import Foundation
import Domain

protocol ProductDataSource {
    func add(_ request: AddProductRequest) throws -> Product
}
