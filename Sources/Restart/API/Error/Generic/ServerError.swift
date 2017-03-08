import Vapor

final class ServerError: ResponseError {
    static let error = make(with: .internalServerError, code: 6, message: "Ups, something went wrong")
}
