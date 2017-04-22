import FluentProvider

extension PriceDiskModel {
    
    static var name: String = "price"
    
    struct Field {
        static let value = "value"
        static let localeId = "locale_id"
    }
}

final class PriceDiskModel: Entity {
    
    let storage = Storage()
    
    var value: Double
    var localeId: Identifier?
    
    public init(value: Double, localeId: Identifier?) {
        self.value = value
        self.localeId = localeId
    }
    
    public init(row: Row) throws {
        value = try row.get(Field.value)
        localeId = try row.get(Field.localeId)
        id = try row.get(idKey)
    }
    
    public func makeRow() throws -> Row {
        var row = Row()
        try row.set(idKey, id)
        try row.set(Field.value, value)
        try row.set(Field.localeId, localeId)
        return row
    }
}

// MARK: - Preparations

extension PriceDiskModel: Preparation {
    
    public static func prepare(_ database: Fluent.Database) throws {
        try database.create(self) { creator in
            creator.id()
            creator.double(Field.value)
            creator.parent(LocaleDiskModel.self, idKey: Field.localeId, optional: false, unique: false)
        }
    }
    
    public static func revert(_ database: Fluent.Database) throws {
        try database.delete(self)
    }
}
