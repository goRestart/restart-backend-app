import ServiceLocator

// MARK: - Validator 

extension Assembly {
    
    func getEmailValidator() -> EmailValidator {
        return EmailValidator()
    }
}

// MARK: - Password hasher

extension Assembly {
    
    func getPasswordHasher() -> PasswordHasher {
        return PasswordHasher(
            hasher: getHasher()
        )
    }
}
