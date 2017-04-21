import Foundation

public protocol Validator {
    associatedtype I
    func validate(_ input: I) -> Bool
}
