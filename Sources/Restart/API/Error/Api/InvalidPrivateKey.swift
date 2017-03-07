import Vapor

struct InvalidPrivateKey {
    static let error = Abort.custom(status: .unauthorized, message: "Invalid private api key")
}
