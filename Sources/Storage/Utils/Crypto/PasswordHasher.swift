import Foundation
import Vapor

/*
    To clarify, I'm not a security expert but this hashing
    algorithm should be enought not to store the password
    in plain text ⚠️
 */
struct PasswordHasher {

    private let hasher: HashProtocol
    private let salt = "RV_(DP-H(ypS7oKk<YlWW%]ELSBK90<77U{r3574r7}-lZ!o9+~Oy>+{zKIj7*i)S}QYoz{O.S.C.A.R}ca:U-;AXuT"

    init(hasher: HashProtocol) {
        self.hasher = hasher
    }

    func hash(userName: String, password: String) throws -> String {
        return try hash(hash(userName.lowercased()) + salt + hash(password))
    }

    private func hash(_ input: String) throws -> String {
        return try hasher.make(input).makeString()
    }
}
