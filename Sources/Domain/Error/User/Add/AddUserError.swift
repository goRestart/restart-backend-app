import Foundation

public enum AddUserError: Error {
    case userNameIsAlreadyInUse
    case emailIsAlreadyInUse
    case invalidEmail
}
