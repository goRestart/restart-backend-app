import Vapor

final class MissingParameters: ResponseError {
    static let error = make(with: .badRequest, code: 5, message: "Invalid request, missing parameter(s)")
}
