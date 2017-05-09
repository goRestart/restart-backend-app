import FluentProvider

extension LocaleDiskModel {
    
    public static var name: String = "locale"
    
    struct Field {
        static let identifier = "locale_id"
    }
}

public final class LocaleDiskModel: Entity {

    public let storage = Storage()
    
    public var localeIdentifier: String
    
    public init(localeIdentifier: String) {
        self.localeIdentifier = localeIdentifier
    }
    
    public init(row: Row) throws {
        localeIdentifier = try row.get(Field.identifier)
        id = try row.get(idKey)
    }
    
    public func makeRow() throws -> Row {
        var row = Row()
        try row.set(Field.identifier, localeIdentifier)
        try row.set(idKey, id)
        return row
    }
}

// MARK: - Preparations

extension LocaleDiskModel: Preparation {
    
    public static func prepare(_ database: Fluent.Database) throws {
        try database.create(self) { creator in
            creator.id()
            creator.string(Field.identifier)
        }
    }
    
    public static func revert(_ database: Fluent.Database) throws {
        try database.delete(self)
    }
}
