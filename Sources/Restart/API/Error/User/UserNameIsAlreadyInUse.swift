import Vapor

struct UserNameIsAlreadyInUse {
    static let error = Abort.custom(status: .conflict, message: "Username is already in use")
}
