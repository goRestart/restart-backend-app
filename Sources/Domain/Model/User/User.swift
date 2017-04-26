import Foundation

public struct User {
    
    public let identifier: String
    public let username: String
    public let firstName: String?
    public let lastName: String?
    public let description: String?
    public let profileImage: Image?
    public let gender: Gender?
    public let email: String
    public let location: Location?
    public let locale: Locale?
    public let birthDate: Date?
    
    public init(identifier: String,
                username: String,
                firstName: String?,
                lastName: String?,
                description: String?,
                profileImage: Image?,
                gender: Gender?,
                email: String,
                location: Location?,
                locale: Locale?,
                birthDate: Date?)
    {
        self.identifier = identifier
        self.username = username
        self.firstName = firstName
        self.lastName = lastName
        self.description = description
        self.profileImage = profileImage
        self.gender = gender
        self.email = email
        self.location = location
        self.locale = locale
        self.birthDate = birthDate
    }
}
