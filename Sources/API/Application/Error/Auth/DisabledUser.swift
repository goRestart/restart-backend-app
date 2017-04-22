final class DisabledUser: ResponseError {
    static let error = make(with: .unauthorized, code: 3, message: "Disabled user")
}
