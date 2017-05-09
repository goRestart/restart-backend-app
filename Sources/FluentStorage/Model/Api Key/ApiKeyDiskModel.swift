import FluentProvider

extension ApiKeyDiskModel {

    public static var name: String = "api_key"
    
    public struct Field {
        public static let privateKey = "private_key"
        public static let publicKey = "public_key"
        public static let enabled = "enabled"
    }
}

public final class ApiKeyDiskModel: Entity {

    public let storage = Storage()
    
    public var privateKey: String
    public var publicKey: String
    public var enabled = true
    
    public init(privateKey: String, publicKey: String, enabled: Bool = true) {
        self.privateKey = privateKey
        self.publicKey = publicKey
        self.enabled = enabled
    }
    
    public init(row: Row) throws {
        privateKey = try row.get(Field.privateKey)
        publicKey = try row.get(Field.publicKey)
        enabled = try row.get(Field.enabled)
        id = try row.get(idKey)
    }
    
    public func makeRow() throws -> Row {
        var row = Row()
        try row.set(idKey, id)
        try row.set(Field.privateKey, privateKey)
        try row.set(Field.publicKey, publicKey)
        try row.set(Field.enabled, enabled)
        return row
    }
}

// MARK: - Preparations

extension ApiKeyDiskModel: Preparation {
    
    public static func prepare(_ database: Fluent.Database) throws {
        try database.create(self) { creator in
            creator.id()
            creator.string(Field.privateKey)
            creator.string(Field.publicKey)
            creator.bool(Field.enabled)
        }
    }

    public static func revert(_ database: Fluent.Database) throws {
        try database.delete(self)
    }
}
