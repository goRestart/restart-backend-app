import Foundation

public enum AuthorizationError: Error {
    case invalidCredentials
    case disabledUser
    case unknown
}
