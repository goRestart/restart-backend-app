import Foundation
import Vapor

/*
    To clarify, I'm not a security expert but this hashing
    algorithm should be enought not to store the password
    in plain text ⚠️
 */
struct PasswordHasher {

    private let hasher: HashProtocol

    init(hasher: HashProtocol) {
        self.hasher = hasher
    }

    func signature(username: String, password: String, salt: String) -> String {
        return username.lowercased() + salt + password
    }
    
    func hash(_ signature: String) throws -> String {
        let hashedPassword = try _hash(signature)
        return hashedPassword
    }

    func check(input: String, matches hash: String) throws -> Bool {
        return try hasher.check(input.makeBytes(), matchesHash: hash.makeBytes())
    }
    
    // Private 
    
    private func _hash(_ input: String) throws -> String {
        return try hasher.make(input).makeString()
    }
}
