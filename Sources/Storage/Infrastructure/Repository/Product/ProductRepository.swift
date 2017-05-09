import Foundation
import Domain

public struct ProductRepository: ProductRepositoryProtocol {
    
    public func add(_ request: AddProductRequest) throws -> Product {
        throw AddProductError.unknown
    }
}
