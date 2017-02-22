import Foundation

protocol Validator {
    associatedtype I
    func validate(input: I) -> Bool
}
