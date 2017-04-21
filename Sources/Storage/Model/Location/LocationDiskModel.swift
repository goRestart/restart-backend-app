import FluentProvider

extension LocationDiskModel {
 
    static var name: String = "location"
    
    struct Field {
        static let latitude = "latitude"
        static let longitude = "longitude"
        static let city = "city"
        static let country = "country"
        static let zip = "zip"
    }
}

final class LocationDiskModel: Entity, Timestampable {
    
    var storage = Storage()
    
    var latitude: Double?
    var longitude: Double?
    var city: String?
    var country: String?
    var zip: String?
    
    init(row: Row) throws {
        latitude = try row.get(Field.latitude)
        longitude = try row.get(Field.longitude)
        city = try row.get(Field.city)
        country = try row.get(Field.country)
        zip = try row.get(Field.zip)
        id = try row.get(idKey)
    }
    
    func makeRow() throws -> Row {
        var row = Row()
        try row.set(Field.latitude, latitude)
        try row.set(Field.longitude, longitude)
        try row.set(Field.city, city)
        try row.set(Field.country, country)
        try row.set(Field.zip, zip)
        try row.set(idKey, id)
        return row
    }
}

// MARK: - Preparations

extension LocationDiskModel: Preparation {

    static func prepare(_ database: Fluent.Database) throws {
        try database.create(self) { creator in
            creator.id()
            creator.double(Field.latitude)
            creator.double(Field.longitude)
            creator.string(Field.city)
            creator.string(Field.country)
            creator.string(Field.zip)
        }
    }
    
    static func revert(_ database: Fluent.Database) throws {
        try database.delete(self)
    }
}
