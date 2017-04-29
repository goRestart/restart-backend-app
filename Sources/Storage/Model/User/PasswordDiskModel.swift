import FluentProvider

extension PasswordDiskModel {
    
    static var name: String = "password"
    static var idType: IdentifierType = .uuid
    
    struct Field {
        static let hash = "hash"
        static let salt = "salt"
        static let userId = "user_id"
    }
}

final class PasswordDiskModel: Entity, Timestampable {
    
    let storage = Storage()
    
    var hash: String
    var salt: String
    var userId: Identifier
    
    public init(hash: String, salt: String, userId: Identifier) {
        self.hash = hash
        self.salt = salt
        self.userId = userId
    }
    
    public init(row: Row) throws {
        hash = try row.get(Field.hash)
        salt = try row.get(Field.salt)
        userId = try row.get(Field.userId)
        id = try row.get(idKey)
    }
    
    public func makeRow() throws -> Row {
        var row = Row()
        try row.set(idKey, id)
        try row.set(Field.hash, hash)
        try row.set(Field.salt, salt)
        try row.set(Field.userId, userId)
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
            creator.parent(UserDiskModel.self, idKey: Field.userId, optional: false, unique: false)
        }
    }
    
    public static func revert(_ database: Fluent.Database) throws {
        try database.delete(self)
    }
}
