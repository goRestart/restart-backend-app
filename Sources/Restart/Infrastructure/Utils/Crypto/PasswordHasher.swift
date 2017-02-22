import Foundation
import Vapor

/*
    To clarify, I'm not a security expert but this hashing
    algorithm should be enought not to store the password
    in plain text ⚠️
 */
struct PasswordHasher {

    private let droplet: Droplet
    private let salt = "RV_(DP-H(ypS7oKk<YlWW%]ELSBK90<77U{r3574r7}-lZ!o9+~Oy>+{zKIj7*i)S}QYoz{O.S.C.A.R}ca:U-;AXuT"

    init(droplet: Droplet) {
        self.droplet = droplet
    }

    func hash(userName: String, password: String) -> String {
        return hash(hash(userName) + salt + hash(password))
    }

    private func hash(_ input: String) -> String {
        do {
            return try droplet.hash.make(input)
        } catch {
            return String(input.characters.reversed())
        }
    }
}
