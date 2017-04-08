import FluentProvider

extension LocaleDiskModel {
    
    static var name: String = "locale"
    
    struct Field {
        static let identifier = "locale_id"
    }
}

final class LocaleDiskModel: Entity {

    var storage = Storage()
    
    var localeIdentifier: String
    
    init(localeIdentifier: String) {
        self.localeIdentifier = localeIdentifier
    }
    
    init(row: Row) throws {
        localeIdentifier = try row.get(Field.identifier)
        id = try row.get(idKey)
    }
    
    func makeRow() throws -> Row {
        var row = Row()
        try row.set(Field.identifier, localeIdentifier)
        try row.set(idKey, id)
        return row
    }
}

// MARK: - Preparations

extension LocaleDiskModel: Preparation {
    
    static func prepare(_ database: Fluent.Database) throws {
        try database.create(self) { creator in
            creator.id(for: self)
            creator.string(Field.identifier)
        }
    }
    
    static func revert(_ database: Fluent.Database) throws {
        try database.delete(self)
    }
}
