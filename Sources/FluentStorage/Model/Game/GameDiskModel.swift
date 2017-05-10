import FluentProvider

extension GameDiskModel {
    
    public static var name: String = "game"
    
    public struct Field {
        public static let title = "title"
        public static let description = "description"
        public static let platformId = "platform_id"
    }
}

public final class GameDiskModel: Entity, Timestampable {
    
    public let storage = Storage()
    
    public var title: String
    public var description: String
    public var platformId: Identifier?
    public var gameGenres: [Identifier?] = []
    
    public init(title: String,
                description: String,
                platformId: Identifier?,
                gameGenres: [Identifier?])
    {
        self.title = title
        self.description = description
        self.platformId = platformId
        self.gameGenres = gameGenres
    }
    
    public init(row: Row) throws {
        title = try row.get(Field.title)
        description = try row.get(Field.description)
        platformId = try row.get(Field.platformId)
        id = try row.get(idKey)
    }
    
    public func makeRow() throws -> Row {
        var row = Row()
        try row.set(Field.title, title)
        try row.set(Field.description, description)
        try row.set(Field.platformId, platformId)
        try row.set(idKey, id)
        return row
    }
}

// MARK: - Relation

extension GameDiskModel {
    
    func platform() throws -> PlatformDiskModel? {
        return try parent(id: platformId).get()
    }
    
    func genres() throws -> [GameGenreDiskModel] {
        let genreIds = gameGenres.map {
            $0!.string!.makeNode(in: nil)
        }
        return try GameGenreDiskModel.makeQuery()
            .filter(.subset(GameGenreDiskModel.idKey, .in, genreIds))
            .all()
    }
}

// MARK: - Preparations

extension GameDiskModel: Preparation {
    
    public static func prepare(_ database: Fluent.Database) throws {
        try database.create(self) { creator in
            creator.id()
            creator.string(Field.title)
            creator.string(Field.description, length: 2000)
            creator.parent(PlatformDiskModel.self, idKey: Field.platformId, optional: false, unique: false)
        }
    }
    
    public static func revert(_ database: Fluent.Database) throws {
        try database.delete(self)
    }
}
