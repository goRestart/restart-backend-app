import FluentProvider

extension PlatformDiskModel {
    
    static var name: String = "platform"
    
    struct Field {
        static let name = "name"
    }
}

final class PlatformDiskModel: Entity {
    
    let storage = Storage()
    
    var name: String
    
    init(name: String) {
        self.name = name
    }
    
    init(row: Row) throws {
        name = try row.get(Field.name)
        id = try row.get(idKey)
    }
    
    func makeRow() throws -> Row {
        var row = Row()
        try row.set(Field.name, name)
        try row.set(idKey, id)
        return row
    }
}

// MARK: - Preparations

extension PlatformDiskModel: Preparation {
    
    static func prepare(_ database: Fluent.Database) throws {
        try database.create(self) { creator in
            creator.id()
            creator.string(Field.name)
        }
    }
    
    static func revert(_ database: Fluent.Database) throws {
        try database.delete(self)
    }
}
