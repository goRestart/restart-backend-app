import Foundation

public struct Suggestion {

    public let identifier: Identifable
    public let value: String
    public let platform: Platform

    public init(identifier: Identifable,
                value: String,
                platform: Platform)
    {
        self.identifier = identifier
        self.value = value
        self.platform = platform
    }
}
