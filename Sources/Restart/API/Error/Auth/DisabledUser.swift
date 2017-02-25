import Vapor

struct DisabledUser {
    static let error = Abort.custom(status: .unauthorized, message: "Disabled user")
}
