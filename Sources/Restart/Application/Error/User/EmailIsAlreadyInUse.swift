import Vapor

struct EmailIsAlreadyInUse {
    static let error = Abort.custom(status: .conflict, message: "Email is already in use")
}
