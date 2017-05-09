import FluentProvider

extension PriceDiskModel {
    
    public static var name: String = "price"
    
    struct Field {
        static let amount = "amount"
        static let localeId = "locale_id"
    }
}

public final class PriceDiskModel: Entity {
    
    public let storage = Storage()
    
    public var amount: Double
    public var localeId: Identifier?
    
    public init(amount: Double, localeId: Identifier?) {
        self.amount = amount
        self.localeId = localeId
    }
    
    public init(row: Row) throws {
        amount = try row.get(Field.amount)
        localeId = try row.get(Field.localeId)
        id = try row.get(idKey)
    }
    
    public func makeRow() throws -> Row {
        var row = Row()
        try row.set(idKey, id)
        try row.set(Field.amount, amount)
        try row.set(Field.localeId, localeId)
        return row
    }
}

// MARK: - Relation

public extension PriceDiskModel {
    
    public func locale() throws  -> LocaleDiskModel? {
        return try parent(id: localeId).get()
    }
}

// MARK: - Preparations

extension PriceDiskModel: Preparation {
    
    public static func prepare(_ database: Fluent.Database) throws {
        try database.create(self) { creator in
            creator.id()
            creator.double(Field.amount)
            creator.parent(LocaleDiskModel.self, idKey: Field.localeId, optional: false, unique: false)
        }
    }
    
    public static func revert(_ database: Fluent.Database) throws {
        try database.delete(self)
    }
}
