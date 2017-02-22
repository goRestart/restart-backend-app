import Foundation
import Vapor
import Fluent

extension UserDiskModel {

    struct Database {
        static let name = "users"
    }

    struct Field {
        static let identifier = "id"
        static let username = "username"
        static let firstName = "first_name"
        static let lastName = "last_name"
        static let description = "description"
        static let profileImageId = "profile_image_id"
        static let gender = "gender"
        static let email = "email"
        static let locationId = "location_id"
        static let userStatus = "user_status"
        static let localeId = "locale_id"
        static let password = "password"
        static let platform = "platform"
        static let applicationVersion = "application_version"
        static let birthDate = "birth_date"
        static let createdAt = "created_at"
        static let updatedAt = "updated_at"
    }
}

public final class UserDiskModel: Model {

    public static var entity: String {
        return Database.name
    }

    public var id: Node?
    var username: String
    var firstName: String?
    var lastName: String?
    var description: String?
    var profileImageId: Node?
    var gender = 0
    var email: String
    var locationId: Node?
    var userStatus = true
    var localeId: Node?
    var password: String
    var platform = 0
    var applicationVersion: Int?
    var birthDate: String?
    var createdAt: String
    var updatedAt: String

    public var exists = false

    init(id: String, username: String, email: String, password: String) {
        self.id = id.makeNode()
        self.username = username
        self.email = email
        self.password = password
        self.createdAt = Date().mysql
        self.updatedAt = Date().mysql
    }

    public init(node: Node, in context: Context) throws {
        id = try node.extract(Field.identifier)
        username = try node.extract(Field.username)
        firstName = try node.extract(Field.firstName)
        lastName = try node.extract(Field.lastName)
        description = try node.extract(Field.description)
        profileImageId = try node.extract(Field.profileImageId)
        gender = try node.extract(Field.gender)
        email = try node.extract(Field.email)
        locationId = try node.extract(Field.locationId)
        userStatus = try node.extract(Field.userStatus)
        localeId = try node.extract(Field.localeId)
        password = try node.extract(Field.password)
        platform = try node.extract(Field.platform)
        createdAt = try node.extract(Field.createdAt)
        updatedAt = try node.extract(Field.updatedAt)
    }

    public func makeNode(context: Context) throws -> Node {
        return try Node(node: [
            Field.identifier: id,
            Field.username: username,
            Field.firstName: firstName,
            Field.lastName: lastName,
            Field.description: description,
            Field.profileImageId: profileImageId,
            Field.gender: gender,
            Field.email: email,
            Field.locationId: locationId,
            Field.userStatus: userStatus,
            Field.localeId: localeId,
            Field.password: password,
            Field.platform: platform,
            Field.applicationVersion: applicationVersion,
            Field.birthDate: birthDate,
            Field.createdAt: createdAt,
            Field.updatedAt: updatedAt
        ])
    }

    // MARK: - Preparations

    public static func prepare(_ database: Fluent.Database) throws {
        try database.create(Database.name) { builder in
            builder.id(Field.identifier)
            builder.string(Field.username, length: nil, optional: false, unique: true, default: nil)
            builder.string(Field.firstName, length: nil, optional: true, unique: false, default: nil)
            builder.string(Field.lastName, length: nil, optional: true, unique: false, default: nil)
            builder.string(Field.description, length: nil, optional: true, unique: false, default: nil)
            builder.parent(idKey: Field.profileImageId, optional: true, unique: false, default: nil)
            builder.tinyInteger(Field.gender, signed: true, optional: false, unique: false, default: 0)
            builder.string(Field.email, length: nil, optional: false, unique: true, default: nil)
            builder.parent(idKey: Field.locationId, optional: true, unique: false, default: nil)
            builder.bool(Field.userStatus, optional: false, unique: false, default: true)
            builder.parent(idKey: Field.localeId, optional: true, unique: false, default: nil)
            builder.string(Field.password, length: nil, optional: false, unique: false, default: nil)
            builder.tinyInteger(Field.platform, signed: true, optional: false, unique: false, default: 0)
            builder.integer(Field.applicationVersion, signed: true, optional: true, unique: false, default: nil)
            builder.date(Field.birthDate, optional: true, unique: false, default: nil)
            builder.date(Field.createdAt)
            builder.date(Field.updatedAt)
        }
    }

    public static func revert(_ database: Fluent.Database) throws {
        try database.delete(Database.name)
    }
}

// MARK - Relations

extension UserDiskModel {

    func profileImage() throws -> ImageDiskModel? {
        return try parent(profileImageId).get()
    }

    func location() throws -> LocationDiskModel? {
        return try parent(locationId).get()
    }

    func locale() throws -> LocaleDiskModel? {
        return try parent(localeId).get()
    }
}
