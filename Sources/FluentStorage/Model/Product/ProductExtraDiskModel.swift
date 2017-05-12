import FluentProvider

extension ProductExtraDiskModel {
    
    public static var name: String = "pr_extra"
    
    public struct Field {
        public static let name = "name"
        public static let value = "value"
    }
}

public final class ProductExtraDiskModel: Entity {
    
    public let storage = Storage()
    
    public var name: String
    public var value: Bool
    
    public init(name: String, value: Bool) {
        self.name = name
        self.value = value
    }
    
    public init(row: Row) throws {
        name = try row.get(Field.name)
        value = try row.get(Field.value)
        id = try row.get(idKey)
    }
    
    public func makeRow() throws -> Row {
        var row = Row()
        try row.set(Field.name, name)
        try row.set(Field.value, value)
        try row.set(idKey, id)
        return row
    }
}

// MARK: - Preparations

extension ProductExtraDiskModel: Preparation {
    
    public static func prepare(_ database: Fluent.Database) throws {
        try database.create(self) { creator in
            creator.id()
            creator.string(Field.name)
            creator.bool(Field.value)
        }
    }
    
    public static func revert(_ database: Fluent.Database) throws {
        try database.delete(self)
    }
}
