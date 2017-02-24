import Foundation

public struct AddUserRequest {

    let userName: String
    let email: String
    let password: String

    public init(userName: String, email: String, password: String) {
        self.userName = userName
        self.email = email
        self.password = password
    }
}
