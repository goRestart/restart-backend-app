import FluentProvider

extension ImageCollectionDiskModel {
    
    public static var name: String = "image_collection"
    
    struct Field {
        static let mainImageId = "main_image_id"
    }
}

public final class ImageCollectionDiskModel: Entity, Timestampable {
    
    public let storage = Storage()

    public var imageIdentifiers: [Identifier] = []
    public var mainImageId: Identifier
    
    public init(imageIdentifiers: [Identifier], mainImageId: Identifier) {
        self.imageIdentifiers = imageIdentifiers
        self.mainImageId = mainImageId
    }
    
    public init(row: Row) throws {
        mainImageId = try row.get(Field.mainImageId)
        id = try row.get(idKey)
    }
    
    public func makeRow() throws -> Row {
        var row = Row()
        try row.set(Field.mainImageId, mainImageId)
        try row.set(idKey, id)
        return row
    }
}

// MARK: - Relation

extension ImageCollectionDiskModel {
    
    public func images() throws -> [ImageDiskModel] {
        return try ImageDiskModel.makeQuery()
            .filter(ImageDiskModel.idKey, Filter.Comparison.contains, imageIdentifiers)
            .all()
    }
}

// MARK: - Preparations

extension ImageCollectionDiskModel: Preparation {
    
    public static func prepare(_ database: Fluent.Database) throws {
        try database.create(self) { creator in
            creator.id()
            creator.parent(ImageDiskModel.self, idKey: Field.mainImageId, optional: false, unique: false)
        }
    }
    
    public static func revert(_ database: Fluent.Database) throws {
        try database.delete(self)
    }
}
