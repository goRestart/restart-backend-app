import FluentProvider

extension GameDiskModel {
    
    public static var name: String = "game"
    
    public struct Field {
        public static let privateKey = ""
    }
}

public final class GameDiskModel: Entity {
    
    public let storage = Storage()
    
    public init(row: Row) throws {

        id = try row.get(idKey)
    }
    
    public func makeRow() throws -> Row {
        var row = Row()
        try row.set(idKey, id)
        return row
    }
}

// MARK: - Preparations

extension GameDiskModel: Preparation {
    
    public static func prepare(_ database: Fluent.Database) throws {
        try database.create(self) { creator in
            creator.id()
        }
    }
    
    public static func revert(_ database: Fluent.Database) throws {
        try database.delete(self)
    }
}
