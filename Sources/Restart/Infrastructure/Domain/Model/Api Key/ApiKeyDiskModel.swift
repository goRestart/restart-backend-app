import Vapor
import Fluent

extension ApiKeyDiskModel {

    struct Database {
        static let name = "api_keys"
    }

    struct Field {
        static let identifier = "id"
        static let privateKey = "private_key"
        static let publicKey = "public_key"
        static let enabled = "enabled"
    }
}

public final class ApiKeyDiskModel: Model {

    public static var entity: String {
        return Database.name
    }

    public var id: Node?
    var privateKey: String
    var publicKey: String
    var enabled = true

    public var exists = false

    init(id: String, privateKey: String, publicKey: String) {
        self.id = id.makeNode()
        self.privateKey = privateKey
        self.publicKey = publicKey
    }

    public init(node: Node, in context: Context) throws {
        id = try node.extract(Field.identifier)
        privateKey = try node.extract(Field.privateKey)
        publicKey = try node.extract(Field.publicKey)
        enabled = try node.extract(Field.enabled)
    }

    public func makeNode(context: Context) throws -> Node {
        return try Node(node: [
            Field.identifier: id,
            Field.privateKey: privateKey,
            Field.publicKey: publicKey,
            Field.enabled: enabled
        ])
    }

    // MARK: - Preparations

    public static func prepare(_ database: Fluent.Database) throws {
        try database.create(Database.name) { builder in
            builder.id(Field.identifier, optional: false, unique: true, default: nil)
            builder.string(Field.privateKey, length: nil, optional: false, unique: true, default: nil)
            builder.string(Field.publicKey, length: nil, optional: false, unique: true, default: nil)
            builder.bool(Field.enabled, optional: false, unique: false, default: true)
        }
    }

    public static func revert(_ database: Fluent.Database) throws {
        try database.delete(Database.name)
    }
}
