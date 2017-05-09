import FluentProvider

extension GenderDiskModel {
    
    static var name: String = "gender"

    struct Field {
        static let value = "value"
    }
}

final class GenderDiskModel: Entity {
    
    var storage = Storage()
    
    var value: String
    
    init(value: String) {
        self.value = value
    }
    
    init(row: Row) throws {
        value = try row.get(Field.value)
        id = try row.get(idKey)
    }
    
    func makeRow() throws -> Row {
        var row = Row()
        try row.set(Field.value, value)
        try row.set(idKey, id)
        return row
    }
}


// MARK: - Preparations

extension GenderDiskModel: Preparation {
    
    static func prepare(_ database: Database) throws {
        try database.create(self) { creator in
            creator.id()
            creator.string(Field.value)
        }
    }
    
    static func revert(_ database: Database) throws {
        try database.delete(self)
    }
}
