final class InvalidPrivateKey: ResponseError {
    static let error = make(with: .unauthorized, code: 2, message: "Invalid private api key")
}
