import FluentProvider

extension UserDiskModel {

    static var name: String = "user"
    static var idType: IdentifierType = .uuid
    
    struct Field {
        static let username = "username"
        static let firstName = "first_name"
        static let lastName = "last_name"
        static let description = "description"
        static let profileImageId = "profile_image_id"
        static let genderId = "gender_id"
        static let email = "email"
        static let locationId = "location_id"
        static let userStatus = "user_status"
        static let localeId = "locale_id"
        static let password = "password"
        static let birthDate = "birth_date"
        static let status = "status"
    }
}

final class UserDiskModel: Entity, Timestampable {

    var storage = Storage()
    
    enum Status: Int {
        case enabled = 0
        case blocked = 1
        case banned = 2
    }
    
    var username: String
    var firstName: String?
    var lastName: String?
    var description: String?
    var profileImageId: Identifier?
    var genderId: Identifier?
    var email: String?
    var locationId: Identifier?
    var localeId: Identifier?
    var password: String
    var birthDate: Date?
    fileprivate var rawStatus: Int = Status.enabled.rawValue

    var status: Status? {
        set {
            rawStatus = newValue!.rawValue
        }
        get {
            return Status(rawValue: rawStatus)
        }
    }

    init(username: String, password: String) {
        self.username = username
        self.password = password
    }
    
    init(row: Row) throws {
        username = try row.get(Field.username)
        firstName = try row.get(Field.firstName)
        lastName = try row.get(Field.lastName)
        description = try row.get(Field.description)
        //profileImageId = try row.get(Field.profileImageId)
        //genderId = try row.get(Field.genderId)
        email = try row.get(Field.profileImageId)
        //locationId = try row.get(Field.locationId)
        //localeId = try row.get(Field.localeId)
        password = try row.get(Field.password)
        birthDate = try row.get(Field.birthDate)
        rawStatus = try row.get(Field.status)
        id = try row.get(idKey)
    }
    
    func makeRow() throws -> Row {
        var row = Row()
        try row.set(Field.username, username)
        try row.set(Field.lastName, lastName)
        try row.set(Field.description, description)
        //try row.set(Field.profileImageId, profileImageId)
        //try row.set(Field.genderId, genderId)
        try row.set(Field.email, email)
        //try row.set(Field.locationId, locationId)
        //try row.set(Field.localeId, localeId)
        try row.set(Field.password, password)
        try row.set(Field.birthDate, birthDate)
        try row.set(Field.status, rawStatus)
        try row.set(idKey, id)
        return row
    }
}

// MARK: - Preparations

extension UserDiskModel: Preparation {
    
    static func prepare(_ database: Fluent.Database) throws {
        try database.create(self) { creator in
            creator.id()
            creator.string(Field.username, optional: false, unique: true)
            creator.string(Field.firstName, optional: true)
            creator.string(Field.lastName, optional: true)
            creator.string(Field.description, optional: true)
//          creator.parent(ImageDiskModel.self, optional: true, unique: false) // TODO: Check documentation for `parent` method
//          creator.parent(GenderDiskModel.self, optional: true, unique: false)
            creator.string(Field.email, optional: true, unique: true)
//          creator.parent(LocationDiskModel.self, optional: true, unique: false)
//          creator.parent(LocaleDiskModel.self, optional: true, unique: false)
            creator.string(Field.password)
            creator.int(Field.status, optional: false, unique: false, default: Status.enabled.rawValue)
            creator.date(Field.birthDate, optional: true)
        }
    }
    
    static func revert(_ database: Fluent.Database) throws {
        try database.delete(self)
    }
}

// MARK - Relations

extension UserDiskModel {

    func gender() throws -> GenderDiskModel? {
        guard let identifier = genderId else { return nil }
        return try parent(id: identifier, type: GenderDiskModel.self).get()
    }
    
    func image() throws -> ImageDiskModel? {
        guard let identifier = profileImageId else { return nil }
        return try parent(id: identifier, type: ImageDiskModel.self).get()
    }

    func location() throws -> LocationDiskModel? {
        guard let identifier = locationId else { return nil }
        return try parent(id: identifier, type: LocationDiskModel.self).get()
    }

    func locale() throws -> LocaleDiskModel? {
        guard let identifier = localeId else { return nil }
        return try parent(id: identifier, type: LocaleDiskModel.self).get()
    }
}
