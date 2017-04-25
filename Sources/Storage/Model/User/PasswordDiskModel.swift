import FluentProvider

extension PasswordDiskModel {
    
    static var name: String = "password"
    static var idType: IdentifierType = .uuid
    
    struct Field {
        static let hash = "hash"
        static let salt = "salt"
    }
}

final class PasswordDiskModel: Entity, Timestampable {
    
    let storage = Storage()
    
    var hash: String
    var salt: String
    

    public init(hash: String, salt: String) {
        self.hash = hash
        self.salt = salt
    }
    
    public init(row: Row) throws {
        hash = try row.get(Field.hash)
        salt = try row.get(Field.salt)
        id = try row.get(idKey)
    }
    
    public func makeRow() throws -> Row {
        var row = Row()
        try row.set(idKey, id)
        try row.set(Field.hash, hash)
        try row.set(Field.salt, salt)
        return row
    }
}

// MARK: - Preparations

extension PasswordDiskModel: Preparation {
    
    public static func prepare(_ database: Fluent.Database) throws {
        try database.create(self) { creator in
            creator.id()
            creator.string(Field.hash)
            creator.string(Field.salt)
        }
    }
    
    public static func revert(_ database: Fluent.Database) throws {
        try database.delete(self)
    }
}
