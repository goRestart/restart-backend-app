import FluentProvider

extension GameDiskModel {
    
    public static var name: String = "game"
    
    public struct Field {
        public static let title = "title"
        public static let description = "description"
    }
}

public final class GameDiskModel: Entity, Timestampable {
    
    public let storage = Storage()
    
    public var title: String
    public var description: String
    
    public init(title: String,
                description: String)
    {
        self.title = title
        self.description = description
    }
    
    public init(row: Row) throws {
        title = try row.get(Field.title)
        description = try row.get(Field.description)
        id = try row.get(idKey)
    }
    
    public func makeRow() throws -> Row {
        var row = Row()
        try row.set(Field.title, title)
        try row.set(Field.description, description)
        try row.set(idKey, id)
        return row
    }
}

// MARK: - Relation

extension GameDiskModel {
    
    func platforms() throws -> Siblings<GameDiskModel, PlatformDiskModel, Pivot<GameDiskModel, PlatformDiskModel>> {
        return siblings()
    }

    func genres() throws -> Siblings<GameDiskModel, GameGenreDiskModel, Pivot<GameDiskModel, GameGenreDiskModel>> {
        return siblings()
    }
}

// MARK: - Preparations

extension GameDiskModel: Preparation {
    
    public static func prepare(_ database: Fluent.Database) throws {
        try database.create(self) { creator in
            creator.id()
            creator.string(Field.title)
            creator.string(Field.description, length: 2000)
        }
    }
    
    public static func revert(_ database: Fluent.Database) throws {
        try database.delete(self)
    }
}
