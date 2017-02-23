import Foundation

enum Field {
    case username(String)
    case email(String)
}

struct VerifyFieldTask {

    func execute(_ field: Field) throws {
        switch field {
        case .username(let value):
            if let _ = try UserDiskModel.query().filter(UserDiskModel.Field.username, value).first() {
                throw AddUserError.userNameIsAlreadyInUse
            }
        case .email(let value):
            if let _ = try UserDiskModel.query().filter(UserDiskModel.Field.email, value).first() {
                throw AddUserError.emailIsAlreadyInUse
            }
        }
    }
}
