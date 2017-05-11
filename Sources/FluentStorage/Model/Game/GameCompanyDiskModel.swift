import FluentProvider

extension GameCompanyDiskModel {
    
    public static var name: String = "game_company"
    
    public struct Field {
        public static let name = "name"
        public static let description = "description"
    }
}

public final class GameCompanyDiskModel: Entity {
    
    public let storage = Storage()
    
    public var name: String
    public var description: String?
    
    public init(name: String, description: String?) {
        self.name = name
        self.description = description
    }
    
    public init(row: Row) throws {
        name = try row.get(Field.name)
        description = try row.get(Field.description)
        id = try row.get(idKey)
    }
    
    public func makeRow() throws -> Row {
        var row = Row()
        try row.set(Field.name, name)
        try row.set(Field.description, description)
        try row.set(idKey, id)
        return row
    }
}

// MARK: - Preparations

extension GameCompanyDiskModel: Preparation {
    
    public static func prepare(_ database: Fluent.Database) throws {
        try database.create(self) { creator in
            creator.id()
            creator.string(Field.name)
            creator.string(Field.description, length: 2000, optional: true)
        }
    }
    
    public static func revert(_ database: Fluent.Database) throws {
        try database.delete(self)
    }
}
