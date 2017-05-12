import FluentProvider

extension ProductDiskModel {
    
    public static var name: String = "product"
    
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

public final class ProductDiskModel: Entity, Timestampable {
    
    public let storage = Storage()
    
    public var title: String
    public var description: String
    public var priceId: Identifier?
    public var platformId: Identifier?
    public var locationId: Identifier?
    public var sellerId: Identifier?

    public init(title: String, description: String, priceId: Identifier?,
         platformId: Identifier?, locationId: Identifier? = nil, sellerId: Identifier? = nil)
    {
        self.title = title
        self.description = description
        self.priceId = priceId
        self.platformId = platformId
        self.locationId = locationId
        self.sellerId = sellerId
    }
    
    public init(row: Row) throws {
        title = try row.get(Field.title)
        description = try row.get(Field.description)
        priceId = try row.get(Field.priceId)
        platformId = try row.get(Field.platformId)
        locationId = try row.get(Field.locationId)
        sellerId = try row.get(Field.sellerId)
        id = try row.get(idKey)
    }
    
    public func makeRow() throws -> Row {
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

public extension ProductDiskModel {
    
    public func price() throws -> PriceDiskModel? {
        return try parent(id: priceId).get()
    }
    
    public func viewCount() throws -> Int {
        return try ViewCountDiskModel.makeQuery()
            .filter(ViewCountDiskModel.Field.productId, id)
            .count()
    }
}

// MARK: - Preparations

extension ProductDiskModel: Preparation {
    
    public static func prepare(_ database: Fluent.Database) throws {
        try database.create(self) { creator in
            creator.id()
            creator.string(Field.title)
            creator.string(Field.description)
            creator.parent(PriceDiskModel.self, idKey: Field.priceId, optional: false, unique: false)
            creator.parent(PlatformDiskModel.self, idKey: Field.platformId, optional: false, unique: false)
            creator.parent(LocationDiskModel.self, idKey: Field.locationId, optional: true, unique: false) // TODO: Remove optional
            creator.parent(UserDiskModel.self, idKey: Field.sellerId, optional: true, unique: false) // TODO: Remove optional
        }
    }
    
    public static func revert(_ database: Fluent.Database) throws {
        try database.delete(self)
    }
}
