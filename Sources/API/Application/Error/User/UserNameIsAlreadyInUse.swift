final class UserNameIsAlreadyInUse: ResponseError {
    static let error = make(with: .conflict, code: 9, message: "Username is already in use")
}
