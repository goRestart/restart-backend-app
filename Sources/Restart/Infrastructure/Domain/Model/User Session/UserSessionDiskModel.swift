import Foundation
import Vapor
import Fluent

extension UserSessionDiskModel {

    struct Database {
        static let name = "user_sessions"
    }

    struct Field {
        static let identifier = "id"
        static let token = "token"
        static let userId = "user_id"
        static let createdAt = "created_at"
        static let validUntil = "valid_until"
    }
}

public final class UserSessionDiskModel: Model {

    public static var entity: String {
        return Database.name
    }

    public var id: Node?
    var token: String
    var createdAt: String
    var userId: String
    var validUntil: String

    public var exists = false

    init(token: String, userId: String, validUntil: Date) {
        self.token = token
        self.userId = userId
        self.createdAt = Date().mysql
        self.validUntil = validUntil.mysql
    }

    public init(node: Node, in context: Context) throws {
        id = try node.extract(Field.identifier)
        token = try node.extract(Field.token)
        userId = try node.extract(Field.userId)
        createdAt = try node.extract(Field.createdAt)
        validUntil = try node.extract(Field.validUntil)
    }

    public func makeNode(context: Context) throws -> Node {
        return try Node(node: [
            Field.identifier: id,
            Field.token: token,
            Field.userId: userId,
            Field.createdAt: createdAt,
            Field.validUntil: validUntil
        ])
    }

    // MARK: - Preparations

    public static func prepare(_ database: Fluent.Database) throws {
        try database.create(Database.name) { builder in
            builder.id(Field.identifier, optional: false, unique: true, default: nil)
            builder.string(Field.token, length: nil, optional: false, unique: true, default: nil)
            builder.string(Field.userId, length: nil, optional: false, unique: false, default: nil)
            builder.datetime(Field.createdAt, optional: false, unique: false, default: nil)
            builder.datetime(Field.validUntil, optional: false, unique: false, default: nil)
        }
    }

    public static func revert(_ database: Fluent.Database) throws {
        try database.delete(Database.name)
    }
}
