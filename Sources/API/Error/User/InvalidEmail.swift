import Vapor

final class InvalidEmail: ResponseError {
    static let error = make(with: .badRequest, code: 8, message: "Invalid email")
}
