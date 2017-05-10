import FluentProvider

extension GameGenreDiskModel {
    
    public static var name: String = "game_genre"
    
    public struct Field {
        public static let translationId = "tr_id"
    }
}

public final class GameGenreDiskModel: Entity {
    
    public let storage = Storage()
    
    public init() {}
    
    public init(row: Row) throws {
        id = try row.get(idKey)
    }
    
    public func makeRow() throws -> Row {
        var row = Row()
        try row.set(idKey, id)
        return row
    }
}

// MARK: - Relation 

extension GameGenreDiskModel {

    func name(`for` locale: LocaleDiskModel) throws -> TranslationDiskModel<GameGenreDiskModel>? {
        return try children().all()
            .filter { element in
            return element.localeId == locale.id
        }.first
    }
}

// MARK: - Preparations

extension GameGenreDiskModel: Preparation {
    
    public static func prepare(_ database: Fluent.Database) throws {
        try database.create(self) { creator in
            creator.id()
        }
    }
    
    public static func revert(_ database: Fluent.Database) throws {
        try database.delete(self)
    }
}
