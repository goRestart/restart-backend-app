import FluentProvider

extension TranslationDiskModel where T: Entity {
    
    public static var name: String {
        return "\(T.entity)_translation"
    }
    
    public struct Field {
        public static var localeId: String {
            return "locale_id"
        }
        public static var parentId: String {
            return "parent_id"
        }
        public static var value: String {
            return "value"
        }
    }
}

public final class TranslationDiskModel<T>: Entity where T: Entity {

    public let storage = Storage()
    
    public var value: String
    public var parentId: Identifier?
    public var localeId: Identifier?
    
    public init(value: String, parentId: Identifier?, localeId: Identifier?) {
        self.value = value
        self.parentId = parentId
        self.localeId = localeId
    }
    
    public init(row: Row) throws {
        value = try row.get(Field.value)
        localeId = try row.get(Field.localeId)
        parentId = try row.get(T.foreignIdKey)
        id = try row.get(idKey)
    }
    
    public func makeRow() throws -> Row {
        var row = Row()
        try row.set(idKey, id)
        try row.set(Field.value, value)
        try row.set(T.foreignIdKey, parentId)
        try row.set(Field.localeId, localeId)
        return row
    }
}

// MARK: - Preparations

extension TranslationDiskModel: Preparation {
    
    public static func prepare(_ database: Fluent.Database) throws {
        try database.create(self) { creator in
            creator.id()
            creator.string(Field.value)
            creator.parent(T.self, optional: false, unique: false, foreignIdKey: T.foreignIdKey)
            creator.parent(LocaleDiskModel.self, optional: false, unique: false, foreignIdKey: Field.localeId)
        }
    }
    
    public static func revert(_ database: Fluent.Database) throws {
        try database.delete(self)
    }
}
