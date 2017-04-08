import Foundation

public enum FieldToVerify {
    case username(String)
    case email(String)
}

public struct VerifyFieldTask {
    
    func execute(_ field: FieldToVerify) throws {
        switch field {
        case .username(let value):
            if let _ = try UserDiskModel.makeQuery().filter(UserDiskModel.Field.username, value).first() {
                throw AddUserError.userNameIsAlreadyInUse
            }
        case .email(let value):
            if let _ = try UserDiskModel.makeQuery().filter(UserDiskModel.Field.email, value).first() {
                throw AddUserError.emailIsAlreadyInUse
            }
        }
    }
}
