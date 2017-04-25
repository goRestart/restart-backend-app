import FluentProvider

extension ViewCountDiskModel {
    
    static var name: String = "view_count"
    static var idType: IdentifierType = .uuid
    
    struct Field {
        static let productId = "product_id"
    }
}

final class ViewCountDiskModel: Entity {
    
    let storage = Storage()
    
    var productId: Identifier
    
    init(productId: Identifier) {
        self.productId = productId
    }

    init(row: Row) throws {
        productId = try row.get(Field.productId)
        id = try row.get(idKey)
    }
    
    func makeRow() throws -> Row {
        var row = Row()
        try row.set(Field.productId, productId)
        try row.set(idKey, id)
        return row
    }
}

// MARK: - Preparations

extension ViewCountDiskModel: Preparation {
    
    static func prepare(_ database: Fluent.Database) throws {
        try database.create(self) { creator in
            creator.id()
            creator.parent(ProductDiskModel.self, idKey: Field.productId, optional: false, unique: false)
        }
    }
    
    static func revert(_ database: Fluent.Database) throws {
        try database.delete(self)
    }
}
