import FluentProvider
import ServiceLocator
import Vapor
import Cache

extension UserDiskModel {

    public static var name: String = "user"
    
    public struct Field {
        public static let username = "username"
        public static let firstName = "first_name"
        public static let lastName = "last_name"
        public static let description = "description"
        public static let profileImageId = "profile_image_id"
        public static let genderId = "gender_id"
        public static let email = "email"
        public static let locationId = "location_id"
        public static let userStatus = "user_status"
        public static let localeId = "locale_id"
        public static let birthDate = "birth_date"
        public static let status = "status"
        public static let passwordHash = "password_hash"
        public static let passwordSalt = "password_salt"
    }
}


public final class UserDiskModel: Entity, Timestampable {

    public let storage = Storage()
    let passwordHasher = UserDiskModel.getPasswordHasher()
    
    public enum Status: Int {
        case blocked = 0
        case enabled = 1
        case banned = 2
    }
    
    public var username: String
    public var firstName: String?
    public var lastName: String?
    public var description: String?
    public var profileImageId: Identifier?
    public var genderId: Identifier?
    public var email: String?
    public var locationId: Identifier?
    public var localeId: Identifier?
    public var birthDate: Date?
    fileprivate var passwordHash: String
    fileprivate var passwordSalt: String
    fileprivate var rawStatus: Int = Status.enabled.rawValue

    public var status: Status? {
        set {
            rawStatus = newValue!.rawValue
        }
        get {
            return Status(rawValue: rawStatus)
        }
    }

    // TODO: Remove this 🔥
    public static func getPasswordHasher() -> PasswordHasher {
        return PasswordHasher(
            hasher: getHasher()
        )
    }
    
    static func getHasher() -> HashProtocol {
        return CryptoHasher(
            hash: .sha256,
            encoding: .hex
        )
    }

    public init(username: String, password: String) throws {
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
    
    public init(row: Row) throws {
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
    
    public func makeRow() throws -> Row {
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
    
    public func check(username: String, password: String) throws -> Bool {
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
    
    public static func prepare(_ database: Fluent.Database) throws {
        try database.create(self) { creator in
            creator.id()
            creator.string(Field.username, optional: false, unique: true)
            creator.string(Field.firstName, optional: true)
            creator.string(Field.lastName, optional: true)
            creator.string(Field.description, optional: true)
            creator.parent(ImageDiskModel.self, optional: true, unique: false, foreignIdKey: Field.profileImageId)
            creator.parent(GenderDiskModel.self, optional: true, unique: false, foreignIdKey: Field.genderId)
            creator.string(Field.email, optional: true, unique: true)
            creator.parent(LocationDiskModel.self, optional: true, unique: false, foreignIdKey: Field.locationId)
            creator.parent(LocaleDiskModel.self, optional: true, unique: false, foreignIdKey: Field.localeId)
            creator.int(Field.status, optional: false, unique: false, default: Status.enabled.rawValue)
            creator.string(Field.passwordHash, optional: false)
            creator.string(Field.passwordSalt, optional: false )
            creator.date(Field.birthDate, optional: true)
        }
    }
    
    public static func revert(_ database: Fluent.Database) throws {
        try database.delete(self)
    }
}
