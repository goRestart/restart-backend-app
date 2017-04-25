import FluentProvider

extension ImageCollectionDiskModel {
    
    static var name: String = "image_collection"
    static var idType: IdentifierType = .uuid
    
    struct Field {
        static let productId = "product_id"
        static let mainImageId = "main_image_id"
    }
}

final class ImageCollectionDiskModel: Entity, Timestampable {
    
    let storage = Storage()

    var productId: Identifier
    var imageIdentifiers: [Identifier] = []
    var mainImageId: Identifier
    
    init(productId: Identifier, imageIdentifiers: [Identifier], mainImageId: Identifier) {
        self.productId = productId
        self.imageIdentifiers = imageIdentifiers
        self.mainImageId = mainImageId
    }
    
    init(row: Row) throws {
        productId = try row.get(Field.productId)
        mainImageId = try row.get(Field.mainImageId)
        id = try row.get(idKey)
    }
    
    func makeRow() throws -> Row {
        var row = Row()
        try row.set(Field.productId, productId)
        try row.set(Field.mainImageId, mainImageId)
        try row.set(idKey, id)
        return row
    }
}

// MARK: - Relation

extension ImageCollectionDiskModel {
    
    func images() throws -> [ImageDiskModel] {
        return try ImageDiskModel.makeQuery()
            .filter(ImageDiskModel.idKey, Filter.Comparison.contains, imageIdentifiers)
            .all()
    }
}

// MARK: - Preparations

extension ImageCollectionDiskModel: Preparation {
    
    static func prepare(_ database: Fluent.Database) throws {
        try database.create(self) { creator in
            creator.id()
            creator.parent(ProductDiskModel.self, idKey: Field.productId, optional: false, unique: false)
            creator.parent(ImageDiskModel.self, idKey: Field.mainImageId, optional: false, unique: false)
        }
    }
    
    static func revert(_ database: Fluent.Database) throws {
        try database.delete(self)
    }
}
