import Vapor

struct InvalidEmail {
    static let error = Abort.custom(status: .badRequest, message: "Invalid email")
}
