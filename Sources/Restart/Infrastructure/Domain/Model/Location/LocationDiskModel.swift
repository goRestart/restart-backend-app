import Vapor
import Fluent

extension LocationDiskModel {

    struct Database {
        static let name = "locations"
    }

    struct Field {
        static let identifier = "id"
        static let locationLatitude = "location_latitude"
        static let locationLongitude = "location_longitude"
        static let city = "city"
        static let country = "country"
        static let zip = "zip"
    }
}

public final class LocationDiskModel: Model {

    public static var entity: String {
        return Database.name
    }

    public var id: Node?
    var locationLatitude: Double?
    var locationLongitude: Double?
    var city: String?
    var country: String?
    var zip: String?

    public var exists = false

    init(id: String) {
        self.id = id.makeNode()
    }

    public init(node: Node, in context: Context) throws {
        id = try node.extract(Field.identifier)
        locationLatitude = try node.extract(Field.locationLatitude)
        locationLongitude = try node.extract(Field.locationLongitude)
        city = try node.extract(Field.city)
        country = try node.extract(Field.country)
        zip = try node.extract(Field.zip)
    }

    public func makeNode(context: Context) throws -> Node {
        return try Node(node: [
            Field.identifier: id,
            Field.locationLatitude: locationLatitude,
            Field.locationLongitude: locationLongitude,
            Field.city: city,
            Field.country: country,
            Field.zip: zip
        ])
    }

    // MARK: - Preparations

    public static func prepare(_ database: Fluent.Database) throws {
        try database.create(Database.name) { builder in
            builder.id(Field.identifier, optional: false, unique: true, default: nil)
            builder.double(Field.locationLatitude, optional: true, unique: false, default: nil)
            builder.double(Field.locationLongitude, optional: true, unique: false, default: nil)
            builder.string(Field.city, length: nil, optional: true, unique: false, default: nil)
            builder.string(Field.country, length: nil, optional: true, unique: false, default: nil)
            builder.string(Field.zip, length: nil, optional: true, unique: false, default: nil)
        }
    }

    public static func revert(_ database: Fluent.Database) throws {
        try database.delete(Database.name)
    }
}
