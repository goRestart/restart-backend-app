import Foundation

public protocol Identifable {

    var value: String { get }

    static func make() -> Identifable
}

public struct Identifier: Identifable {

    public var value: String

    public init(_ value: String) {
        self.value = value
    }

    public static func make() -> Identifable {
        let uuid = UUID().uuidString
        return Identifier(uuid)
    }
}
