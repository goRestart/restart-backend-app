import FluentProvider

extension Localizable where T: Entity {
    
    public static var name: String {
        return "\(T.entity)_string"
    }
    
    public struct Field {
        public static var value: String { return "value" }
        public static var key: String { return "key" }
        public static var localeId: String { return "locale_id" }
    }
}

public final class Localizable<T>: Entity where T: Entity {
    
    public let storage = Storage()
    
    public var value: String
    public var key: String
    public var localeId: Identifier?
    
    public init(value: String, key: String, localeId: Identifier?) {
        self.value = value
        self.key = key
        self.localeId = localeId
    }
    
    public init(row: Row) throws {
        value = try row.get(Field.value)
        key = try row.get(Field.key)
        id = try row.get(idKey)
    }
    
    public func makeRow() throws -> Row {
        var row = Row()
        try row.set(idKey, id)
        try row.set(Field.value, value)
        try row.set(Field.key, key)
        try row.set(Field.localeId, localeId)
        return row
    }
}

// MARK: - Get

extension Localizable {
    
    static func string(_ key: String, _ localeId: Identifier?) throws -> String {
        let localizable = try Localizable<T>.makeQuery()
            .filter(Field.key, key)
            .filter(Field.localeId, localeId)
            .first()
        guard let value = localizable?.value else {
            return key
        }
        return value
    }
}

// MARK: - Preparations

extension Localizable: Preparation {
    
    public static func prepare(_ database: Fluent.Database) throws {
        try database.create(self) { creator in
            creator.id()
            creator.string(Field.value)
            creator.string(Field.key)
            creator.parent(LocaleDiskModel.self, optional: false, unique: false, foreignIdKey: Field.localeId)
        }
    }
    
    public static func revert(_ database: Fluent.Database) throws {
        try database.delete(self)
    }
}
