import ServiceLocator

// MARK: - Validators

public extension Assembly {
    
    public func getEmailValidator() -> EmailValidator {
        return EmailValidator()
    }
}
