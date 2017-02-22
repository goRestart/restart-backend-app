import Foundation

private let minimumNumberOfCharacters = 6 // a@a.io

/*
    This is not the best way to validate emails but at least works
 */
struct EmailValidator: Validator {

    func validate(input: String) -> Bool {
        return input.contains("@")
            && input.contains(".")
            && input.characters.count > minimumNumberOfCharacters
    }
}
