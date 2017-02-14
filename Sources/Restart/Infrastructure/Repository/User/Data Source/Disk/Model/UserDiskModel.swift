import Vapor
import Fluent

extension UserDiskModel {

    fileprivate struct Database {
        static let name = "users"
    }

    struct Field {
        static let identifier = "id"
        static let username = "username"
        static let email = "email"
        static let password = "password"
    }
}

public final class UserDiskModel: Model {

    public var id: Node?
    var username: String
    var email: String
    var password: String
    public var exists = false

    init(id: String, username: String, email: String, password: String) {
        self.id = id.makeNode()
        self.username = username
        self.email = email
        self.password = password
    }

    public init(node: Node, in context: Context) throws {
        id = try node.extract(Field.identifier)
        username = try node.extract(Field.username)
        email = try node.extract(Field.email)
        password = try node.extract(Field.password)
    }

    public func makeNode(context: Context) throws -> Node {
        return try Node(node: [
            Field.identifier: id,
            Field.username: username,
            Field.email: email,
            Field.password: password
        ])
    }

    // MARK: - Preparations

    public static func prepare(_ database: Fluent.Database) throws {
        try database.create(Database.name) { users in
            users.id(Field.identifier, optional: false, unique: true, default: nil)
            users.string(Field.username, length: nil, optional: false, unique: true, default: nil)
            users.string(Field.email, length: nil, optional: false, unique: true, default: nil)
            users.string(Field.password, length: nil, optional: false, unique: false, default: nil)
        }
    }

    public static func revert(_ database: Fluent.Database) throws {
        try database.delete(Database.name)
    }
}
