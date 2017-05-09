import FluentProvider

extension ProductDiskModel {
    
    static var name: String = "product"
    static var idType: IdentifierType = .uuid
    
    struct Field {
        static let title = "title"
        static let description = "description"
        static let priceId = "price_id"
        static let platformId = "platform_id"
        static let viewCountId = "view_count_id"
        static let locationId = "location_id"
        static let sellerId = "seller_id"
    }
}

final class ProductDiskModel: Entity, Timestampable {
    
    let storage = Storage()
    
    var title: String
    var description: String
    var priceId: Identifier
    var platformId: Identifier
    var locationId: Identifier
    var sellerId: Identifier

    init(title: String, description: String, priceId: Identifier,
         platformId: Identifier, locationId: Identifier, sellerId: Identifier)
    {
        self.title = title
        self.description = description
        self.priceId = priceId
        self.platformId = platformId
        self.locationId = locationId
        self.sellerId = sellerId
    }
    
    init(row: Row) throws {
        title = try row.get(Field.title)
        description = try row.get(Field.description)
        priceId = try row.get(Field.priceId)
        platformId = try row.get(Field.platformId)
        locationId = try row.get(Field.locationId)
        sellerId = try row.get(Field.sellerId)
        id = try row.get(idKey)
    }
    
    func makeRow() throws -> Row {
        var row = Row()
        try row.set(Field.title, title)
        try row.set(Field.description, description)
        try row.set(Field.priceId, priceId)
        try row.set(Field.platformId, platformId)
        try row.set(Field.locationId, locationId)
        try row.set(Field.sellerId, sellerId)
        try row.set(idKey, id)
        return row
    }
}

// MARK - Relations

extension ProductDiskModel {
    
    func imageCollection() throws -> ImageCollectionDiskModel? {
        return try ImageCollectionDiskModel.makeQuery()
            .filter(ImageCollectionDiskModel.Field.productId, id)
            .first()
    }
    
    func viewCount() throws -> Int {
        return try ViewCountDiskModel.makeQuery()
            .filter(ViewCountDiskModel.Field.productId, id)
            .count()
    }
}

// MARK: - Preparations

extension ProductDiskModel: Preparation {
    
    static func prepare(_ database: Fluent.Database) throws {
        try database.create(self) { creator in
            creator.id()
            creator.string(Field.title)
            creator.string(Field.description)
            creator.parent(PriceDiskModel.self, idKey: Field.priceId, optional: false, unique: false)
            creator.parent(PlatformDiskModel.self, idKey: Field.platformId, optional: false, unique: false)
            creator.parent(LocationDiskModel.self, idKey: Field.locationId, optional: true, unique: false)
            creator.parent(UserDiskModel.self, idKey: Field.sellerId, optional: false, unique: false)
        }
    }
    
    static func revert(_ database: Fluent.Database) throws {
        try database.delete(self)
    }
}
