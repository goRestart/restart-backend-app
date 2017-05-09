import Foundation
import Domain
import FluentStorage

public enum FieldToVerify {
    case username(String)
    case email(String)
}

public struct VerifyFieldTask {
    
    public func execute(_ field: FieldToVerify) throws {
        switch field {
        case .username(let value):
            if let _ = try UserDiskModel.makeQuery().filter(raw: "\(UserDiskModel.Field.username) = lower('\(value.lowercased())')").first() {
                throw AddUserError.userNameIsAlreadyInUse
            }
        case .email(let value):
            if let _ = try UserDiskModel.makeQuery().filter(raw: "\(UserDiskModel.Field.email) = lower('\(value.lowercased())')").first() {
                throw AddUserError.emailIsAlreadyInUse
            }
        }
    }
}
