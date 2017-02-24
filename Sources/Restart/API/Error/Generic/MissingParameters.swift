import Vapor

struct MissingParameters {
    static let error = Abort.custom(status: .badRequest, message: "Invalid request, missing parameter(s)")
}
