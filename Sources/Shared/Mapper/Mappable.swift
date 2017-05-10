import Foundation

public protocol Mappable {

    associatedtype From
    associatedtype To

    func map(_ from: From) -> To
}

extension Mappable {

    public func map(array from: [From]) -> [To] {
        return from.map { from in
            return map(from)
        }
    }
}
