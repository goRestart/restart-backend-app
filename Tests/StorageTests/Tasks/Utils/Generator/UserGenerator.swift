import Foundation
@testable import FluentStorage

// MARK: - Helpers
@discardableResult
func givenDisabledUser(with username: String, password: String) -> UserDiskModel {
    return givenUser(with: username, password: password, disabled: true)
}

@discardableResult
func givenUser(with username: String, password: String, email: String = "hi@restart.ninja", disabled: Bool = false) -> UserDiskModel {
    let user = try! UserDiskModel(
        username: username,
        password: password
    )
    
    user.email = email
    user.status = disabled ? .banned: .enabled
    
    try! user.save()
    
    return user
}
