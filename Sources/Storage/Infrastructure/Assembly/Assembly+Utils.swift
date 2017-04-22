import ServiceLocator

// MARK: - Password hasher

extension Assembly {
    
    func getPasswordHasher() -> PasswordHasher {
        let droplet = getDroplet()
        return PasswordHasher(
            hasher: droplet.hash
        )
    }
}
