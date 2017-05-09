import FluentProvider

extension ImageDiskModel {

    public static var name: String = "image"
    public static var idType: IdentifierType = .uuid
    
    struct Field {
        static let url = "url"
        static let width = "width"
        static let height = "height"
        static let size = "size"
        static let color = "color"
    }
}

public final class ImageDiskModel: Entity, Timestampable {

    public let storage = Storage()
    
    public var url: String
    public var width: Double
    public var height: Double
    public var size: Double
    public var color: Int?
    
    public init(url: String, width: Double, height: Double, size: Double) {
        self.url = url
        self.width = width
        self.height = height
        self.size = size
    }
    
    public init(row: Row) throws {
        url = try row.get(Field.url)
        width = try row.get(Field.width)
        height = try row.get(Field.height)
        size = try row.get(Field.size)
        color = try row.get(Field.color)
        id = try row.get(idKey)
    }
    
    public func makeRow() throws -> Row {
        var row = Row()
        try row.set(Field.url, url)
        try row.set(Field.width, width)
        try row.set(Field.height, height)
        try row.set(Field.size, size)
        try row.set(Field.color, color)
        try row.set(idKey, id)
        return row
    }
}

// MARK: - Preparations

extension ImageDiskModel: Preparation {
    
    public static func prepare(_ database: Fluent.Database) throws {
        try database.create(self) { creator in
            creator.id()
            creator.string(Field.url)
            creator.double(Field.width)
            creator.double(Field.height)
            creator.double(Field.size)
            creator.int(Field.color, optional: true)
        }
    }
    
    public static func revert(_ database: Fluent.Database) throws {
        try database.delete(self)
    }
}
