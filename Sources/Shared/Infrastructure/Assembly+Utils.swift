import ServiceLocator
import Vapor
import Cache

// MARK: - Validator 

public extension Assembly {
    
    public func getEmailValidator() -> EmailValidator {
        return EmailValidator()
    }
}
