import Foundation

public struct UserSession {
    
    public let token: String
    public let validUntil: Date
    
    public init(token: String,
                validUntil: Date)
    {
        self.token = token
        self.validUntil = validUntil
    }
}
