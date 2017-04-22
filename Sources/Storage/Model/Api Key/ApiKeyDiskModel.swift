import FluentProvider

extension ApiKeyDiskModel {

    static var name: String = "api_key"
    
    struct Field {
        static let privateKey = "private_key"
        static let publicKey = "public_key"
        static let enabled = "enabled"
    }
}

final class ApiKeyDiskModel: Entity {

    let storage = Storage()
    
    var privateKey: String
    var publicKey: String
    var enabled = true
    
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
