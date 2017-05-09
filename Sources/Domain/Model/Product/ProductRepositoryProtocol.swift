import Foundation

public protocol ProductRepositoryProtocol {
    func add(_ request: AddProductRequest) throws -> Product
}
