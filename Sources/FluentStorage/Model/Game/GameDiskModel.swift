import FluentProvider

extension GameDiskModel {
    
    public static var name: String = "game"
    
    public struct Field {
        public static let title = "title"
        public static let description = "description"
        public static let released = "released"
        public static let companyId = "companyId"
    }
}

public final class GameDiskModel: Entity, Timestampable {
    
    public let storage = Storage()
    
    public var title: String
    public var description: String
    public var companyId: Identifier?
    public var released: Date

    public init(title: String,
                description: String,
                companyId: Identifier?,
                released: Date)
    {
        self.title = title
        self.description = description
        self.companyId = companyId
        self.released = released
    }
    
    public init(row: Row) throws {
        title = try row.get(Field.title)
        description = try row.get(Field.description)
        companyId = try row.get(Field.companyId)
        released = try row.get(Field.released)
        id = try row.get(idKey)
    }
    
    public func makeRow() throws -> Row {
        var row = Row()
        try row.set(Field.title, title)
        try row.set(Field.description, description)
        try row.set(Field.companyId, companyId)
        try row.set(Field.released, released)
        try row.set(idKey, id)
        return row
    }
}

// MARK: - Relation

extension GameDiskModel {
    
    func images() throws -> Siblings<GameDiskModel, ImageDiskModel, Pivot<GameDiskModel, ImageDiskModel>> {
        return siblings()
    }
    
    func company() throws -> GameCompanyDiskModel? {
        return try parent(id: companyId).get()
    }
    
    func platforms() throws -> Siblings<GameDiskModel, PlatformDiskModel, Pivot<GameDiskModel, PlatformDiskModel>> {
        return siblings()
    }

    func genres() throws -> Siblings<GameDiskModel, GameGenreDiskModel, Pivot<GameDiskModel, GameGenreDiskModel>> {
        return siblings()
    }
    
    func alternativeNames() throws -> Siblings<GameDiskModel, GameAlternativeNameDiskModel, Pivot<GameDiskModel, GameAlternativeNameDiskModel>> {
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
            creator.parent(GameCompanyDiskModel.self, optional: false, unique: false, foreignIdKey: Field.companyId)
            creator.date(Field.released)
        }
    }
    
    public static func revert(_ database: Fluent.Database) throws {
        try database.delete(self)
    }
}
