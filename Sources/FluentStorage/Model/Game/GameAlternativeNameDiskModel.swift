import FluentProvider

extension GameAlternativeNameDiskModel {
    
    public static var name: String = "alt_name"
    
    public struct Field {
        public static let name = "name"
    }
}

public final class GameAlternativeNameDiskModel: Entity {
    
    public let storage = Storage()
    
    public var name: String
    
    public init(name: String) {
        self.name = name
    }
    
    public init(row: Row) throws {
        name = try row.get(Field.name)
        id = try row.get(idKey)
    }
    
    public func makeRow() throws -> Row {
        var row = Row()
        try row.set(Field.name, name)
        try row.set(idKey, id)
        return row
    }
}

// MARK: - Preparations

extension GameAlternativeNameDiskModel: Preparation {
    
    public static func prepare(_ database: Fluent.Database) throws {
        try database.create(self) { creator in
            creator.id()
            creator.string(Field.name)
        }
    }
    
    public static func revert(_ database: Fluent.Database) throws {
        try database.delete(self)
    }
}
