import FluentProvider

extension UserSessionDiskModel {
    
    public static var name: String = "user_session"
    
    struct Field {
        static let identifier = "id"
        static let token = "token"
        static let userId = "user_id"
        static let createdAt = "created_at"
        static let validUntil = "valid_until"
    }
}

public final class UserSessionDiskModel: Entity, Timestampable {
    
    public let storage = Storage()
    
    public var token: String
    public var userId: String
    public var validUntil: Date
    
    public init(token: String, userId: String, validUntil: Date) {
        self.token = token
        self.userId = userId
        self.validUntil = validUntil
    }
    
    public init(row: Row) throws {
        token = try row.get(Field.token)
        userId = try row.get(Field.userId)
        validUntil = try row.get(Field.validUntil)
        id = try row.get(idKey)
    }
    
    public func makeRow() throws -> Row {
        var row = Row()
        try row.set(idKey, id)
        try row.set(Field.token, token)
        try row.set(Field.userId, userId)
        try row.set(Field.validUntil, validUntil)
        return row
    }
}

// MARK: - Preparations

extension UserSessionDiskModel: Preparation {
    
    public static func prepare(_ database: Fluent.Database) throws {
        try database.create(self) { creator in
            creator.id()
            creator.string(Field.token)
            creator.string(Field.userId)
            creator.date(Field.validUntil)
        }
    }
    
    public static func revert(_ database: Fluent.Database) throws {
        try database.delete(self)
    }
}
