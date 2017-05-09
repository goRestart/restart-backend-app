import FluentProvider

extension ImageDiskModel {

    static var name: String = "image"
    static var idType: IdentifierType = .uuid
    
    struct Field {
        static let url = "url"
        static let width = "width"
        static let height = "height"
        static let size = "size"
        static let color = "color"
    }
}

final class ImageDiskModel: Entity, Timestampable {

    let storage = Storage()
    
    var url: String
    var width: Double
    var height: Double
    var size: Double
    var color: Int?
    
    init(url: String, width: Double, height: Double, size: Double) {
        self.url = url
        self.width = width
        self.height = height
        self.size = size
    }
    
    init(row: Row) throws {
        url = try row.get(Field.url)
        width = try row.get(Field.width)
        height = try row.get(Field.height)
        size = try row.get(Field.size)
        color = try row.get(Field.color)
        id = try row.get(idKey)
    }
    
    func makeRow() throws -> Row {
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
    
    static func prepare(_ database: Fluent.Database) throws {
        try database.create(self) { creator in
            creator.id()
            creator.string(Field.url)
            creator.double(Field.width)
            creator.double(Field.height)
            creator.double(Field.size)
            creator.int(Field.color, optional: true)
        }
    }
    
    static func revert(_ database: Fluent.Database) throws {
        try database.delete(self)
    }
}
