import Foundation
import Shared

private let minimumNumberOfCharacters = 6 // a@a.io

/*
    This is not the best way to validate emails but at least works
 */
struct EmailValidator: Validator {

    func validate(_ input: String) -> Bool {
        return input.contains("@")
            && input.contains(".")
            && input.components(separatedBy: "@").last != nil
            && input.characters.count > minimumNumberOfCharacters
    }
}
