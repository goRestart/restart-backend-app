final class InvalidCredentials: ResponseError {
    static let error = make(with: .unauthorized, code: 4, message: "Invalid credentials")
}
