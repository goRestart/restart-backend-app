final class InvalidHash: ResponseError {
    static let error = make(with: .unauthorized, code: 1, message: "Invalid hash")
}
