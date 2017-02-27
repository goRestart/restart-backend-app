import Foundation

struct UserSessionDiskModelToDomainMapper: Mappable {

    func map(_ from: UserSessionDiskModel) -> UserSession {
        let validUntil = try! Date(mysql: from.validUntil)
        return UserSession(
            token: from.token,
            validUntil: validUntil
        )
    }
}
