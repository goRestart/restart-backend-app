final class EmailIsAlreadyInUse: ResponseError {
    static let error = make(with: .conflict, code: 7, message: "Email is already in use")
}
