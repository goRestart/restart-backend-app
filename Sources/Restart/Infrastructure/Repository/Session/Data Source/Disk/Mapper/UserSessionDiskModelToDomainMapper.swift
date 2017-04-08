import Foundation

struct UserSessionDiskModelToDomainMapper: Mappable {

    func map(_ from: UserSessionDiskModel) -> UserSession {
        return UserSession(
            token: from.token,
            validUntil: from.validUntil
        )
    }
}
