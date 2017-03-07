import Vapor

struct InvalidHash {
    static let error = Abort.custom(status: .unauthorized, message: "Invalid hash")
}
