import Foundation

public struct AddSessionRequest {
    let userId: String
    let validityInterval: TimeInterval
    
    public init(userId: String,
                validityInterval: TimeInterval)
    {
        self.userId = userId
        self.validityInterval = validityInterval
    }
}
