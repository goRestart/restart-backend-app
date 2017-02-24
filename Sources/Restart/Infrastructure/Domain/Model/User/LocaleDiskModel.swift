import Vapor
import Fluent

extension LocaleDiskModel {

    struct Database {
        static let name = "locales"
    }

    struct Field {
        static let identifier = "id"
        static let languageCode = "languageCode"
    }
}

public final class LocaleDiskModel: Model {

    public static var entity: String {
        return Database.name
    }

    public var id: Node?
    var languageCode: String?

    public var exists = false

    init(id: String, languageCode: String?) {
        self.id = id.makeNode()
        self.languageCode = languageCode
    }

    public init(node: Node, in context: Context) throws {
        id = try node.extract(Field.identifier)
        languageCode = try node.extract(Field.languageCode)
    }

    public func makeNode(context: Context) throws -> Node {
        return try Node(node: [
            Field.identifier: id,
            Field.languageCode: languageCode,
        ])
    }

    // MARK: - Preparations

    public static func prepare(_ database: Fluent.Database) throws {
        try database.create(Database.name) { builder in
            builder.id(Field.identifier, optional: false, unique: true, default: nil)
            builder.string(Field.languageCode, length: nil, optional: true, unique: false, default: nil)
        }
    }

    public static func revert(_ database: Fluent.Database) throws {
        try database.delete(Database.name)
    }
}
