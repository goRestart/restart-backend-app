import Foundation

public struct User {
    let identifier: String
    let userName: String
    let firstName: String?
    let lastName: String?
    let description: String?
    let profileImage: Image?
    let gender: Gender = .unknown
    let email: String
    let location: Location?
    let status: UserStatus
    let locale: Locale?
    let platform: UserPlatform = .unknown
    let applicationVersion: Int?
    let birtdate: Date?
    let createdAt: Date
    let updatedAt: Date
}
