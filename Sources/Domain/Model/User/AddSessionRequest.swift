import Foundation

public struct AddSessionRequest {
    
    public let userId: String
    public let validityInterval: TimeInterval
    
    public init(userId: String,
                validityInterval: TimeInterval)
    {
        self.userId = userId
        self.validityInterval = validityInterval
    }
}
