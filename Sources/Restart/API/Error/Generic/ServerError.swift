import Vapor

struct ServerError {
    static let error = Abort.serverError
}
