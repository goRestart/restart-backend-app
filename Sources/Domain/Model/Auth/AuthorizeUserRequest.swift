import Foundation

public struct AuthorizeUserRequest {
    
    public let userName: String
    public let password: String
    
    public init(userName: String,
                password: String)
    {
        self.userName = userName
        self.password = password
    }
}
