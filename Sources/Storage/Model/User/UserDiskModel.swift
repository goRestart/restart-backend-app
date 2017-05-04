import FluentProvider
import ServiceLocator

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
        static let birthDate = "birth_date"
        static let status = "status"
        static let passwordHash = "password_hash"
        static let passwordSalt = "password_salt"
    }
}

final class UserDiskModel: Entity, Timestampable {

    let storage = Storage()
    let passwordHasher = Dependency().getPasswordHasher()
    
    enum Status: Int {
        case blocked = 0
        case enabled = 1
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
    var birthDate: Date?
    fileprivate var passwordHash: String
    fileprivate var passwordSalt: String
    fileprivate var rawStatus: Int = Status.enabled.rawValue

    var status: Status? {
        set {
            rawStatus = newValue!.rawValue
        }
        get {
            return Status(rawValue: rawStatus)
        }
    }

    init(username: String, password: String) throws {
        self.username = username
        
        let salt = UUID().uuidString
        let signature = passwordHasher.signature(
            username: username,
            password: password,
            salt: salt
        )
        let hash = try passwordHasher.hash(signature)
        self.passwordHash = hash
        self.passwordSalt = salt
    }
    
    init(row: Row) throws {
        username = try row.get(Field.username)
        firstName = try row.get(Field.firstName)
        lastName = try row.get(Field.lastName)
        description = try row.get(Field.description)
        profileImageId = try row.get(Field.profileImageId)
        genderId = try row.get(Field.genderId)
        email = try row.get(Field.email)
        locationId = try row.get(Field.locationId)
        localeId = try row.get(Field.localeId)
        birthDate = try row.get(Field.birthDate)
        rawStatus = try row.get(Field.status)
        passwordHash = try row.get(Field.passwordHash)
        passwordSalt = try row.get(Field.passwordSalt)
        id = try row.get(idKey)
    }
    
    func makeRow() throws -> Row {
        var row = Row()
        try row.set(Field.username, username)
        try row.set(Field.lastName, lastName)
        try row.set(Field.description, description)
        try row.set(Field.profileImageId, profileImageId)
        try row.set(Field.genderId, genderId)
        try row.set(Field.email, email)
        try row.set(Field.locationId, locationId)
        try row.set(Field.localeId, localeId)
        try row.set(Field.birthDate, birthDate)
        try row.set(Field.status, rawStatus)
        try row.set(Field.passwordHash, passwordHash)
        try row.set(Field.passwordSalt, passwordSalt)
        try row.set(idKey, id)
        return row
    }
}

// MARK: - Actions

extension UserDiskModel {
    
    func check(username: String, password: String) throws -> Bool {
        let signature = passwordHasher.signature(
            username: username,
            password: password,
            salt: passwordSalt
        )
        return try passwordHasher.check(
            input: signature,
            matches: passwordHash
        )
    }
}


// MARK: - Relations

extension UserDiskModel {
 
    func gender() throws -> GenderDiskModel? {
        return try parent(id: genderId).get()
    }
    
    func image() throws -> ImageDiskModel? {
        return try parent(id: profileImageId).get()
    }
    
    func location() throws -> LocationDiskModel? {
        return try parent(id: locationId).get()
    }
    
    func locale() throws -> LocaleDiskModel? {
        return try parent(id: localeId).get()
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
            creator.parent(ImageDiskModel.self, idKey: Field.profileImageId, optional: true, unique: false)
            creator.parent(GenderDiskModel.self, idKey: Field.genderId, optional: true, unique: false)
            creator.string(Field.email, optional: true, unique: true)
            creator.parent(LocationDiskModel.self, idKey: Field.locationId, optional: true, unique: false)
            creator.parent(LocaleDiskModel.self, idKey: Field.localeId, optional: true, unique: false)
            creator.int(Field.status, optional: false, unique: false, default: Status.enabled.rawValue)
            creator.string(Field.passwordHash, optional: false)
            creator.string(Field.passwordSalt, optional: false )
            creator.date(Field.birthDate, optional: true)
        }
    }
    
    static func revert(_ database: Fluent.Database) throws {
        try database.delete(self)
    }
}
