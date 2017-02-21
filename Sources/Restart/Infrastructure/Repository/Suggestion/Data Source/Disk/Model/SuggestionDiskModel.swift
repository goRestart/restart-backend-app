import Vapor
import Fluent

extension SuggestionDiskModel {

    fileprivate struct Database {
        static let name = "suggestions"
    }

    struct Field {
        static let identifier = "id"
        static let value = "value"
        static let platform = "platform"
    }
}

public final class SuggestionDiskModel: Model {

    public static var entity: String {
        return Database.name
    }

    public var id: Node?
    var value: String
    var platform: Int
    public var exists = false

    init(id: String, value: String, platform: Int) {
        self.id = id.makeNode()
        self.value = value
        self.platform = platform
    }

    public init(node: Node, in context: Context) throws {
        id = try node.extract(Field.identifier)
        value = try node.extract(Field.value)
        platform = try node.extract(Field.platform)
    }

    public func makeNode(context: Context) throws -> Node {
        return try Node(node: [
            Field.identifier: id,
            Field.value: value,
            Field.platform: platform
        ])
    }

    // MARK: - Preparations 

    public static func prepare(_ database: Fluent.Database) throws {
        try database.create(Database.name) { builder in
            builder.id(Field.identifier, optional: false, unique: true, default: nil)
            builder.string(Field.value)
            builder.int(Field.platform)
        }
    }

    public static func revert(_ database: Fluent.Database) throws {
        try database.delete(Database.name)
    }
}
