import ServiceLocator

// MARK: - Validators

extension Assembly {

    func getEmailValidator() -> EmailValidator {
        return EmailValidator()
    }
}

// MARK: - Password hasher

extension Assembly {

    func getPasswordHasher() -> PasswordHasher {
        let droplet = getDroplet()
        return PasswordHasher(
            hasher: droplet.hash
        )
    }
}
