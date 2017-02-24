import Vapor
import Fluent

extension ImageDiskModel {

    struct Database {
        static let name = "images"
    }

    struct Field {
        static let identifier = "id"
        static let url = "url"
        static let size = "size"
        static let width = "width"
        static let height = "height"
    }
}

public final class ImageDiskModel: Model {

    public static var entity: String {
        return Database.name
    }

    public var id: Node?
    var url: String
    var size: Int
    var width: Double
    var height: Double

    public var exists = false

    init(id: String, url: String, imageSize: ImageSize, width: Double, height: Double) {
        self.id = id.makeNode()
        self.url = url
        self.size = imageSize.rawValue
        self.width = width
        self.height = height
    }

    public init(node: Node, in context: Context) throws {
        id = try node.extract(Field.identifier)
        url = try node.extract(Field.url)
        size = try node.extract(Field.size)
        width = try node.extract(Field.width)
        height = try node.extract(Field.height)
    }

    public func makeNode(context: Context) throws -> Node {
        return try Node(node: [
            Field.identifier: id,
            Field.url: url,
            Field.size: size,
            Field.width: width,
            Field.height: height
        ])
    }

    // MARK: - Preparations

    public static func prepare(_ database: Fluent.Database) throws {
        try database.create(Database.name) { builder in
            builder.id(Field.identifier, optional: false, unique: true, default: nil)
            builder.string(Field.url, length: nil, optional: false, unique: true, default: nil)
            builder.integer(Field.size)
            builder.double(Field.width)
            builder.double(Field.height)
        }
    }

    public static func revert(_ database: Fluent.Database) throws {
        try database.delete(Database.name)
    }
}
