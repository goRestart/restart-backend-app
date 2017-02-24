import Foundation

protocol Validator {
    associatedtype I
    func validate(_ input: I) -> Bool
}
