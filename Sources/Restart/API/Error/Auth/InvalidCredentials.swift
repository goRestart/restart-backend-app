import Vapor

struct InvalidCredentials {
    static let error = Abort.custom(status: .unauthorized, message: "Invalid credentials")
}
