import Foundation

public struct AuthorizeUserRequest {
    let userName: String
    let password: String
    let timestamp: String
    let hash: String
}
