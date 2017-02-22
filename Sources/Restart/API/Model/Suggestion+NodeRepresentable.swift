import Node

private struct JSONFields {
    static let identifier = "identifier"
    static let value = "value"
    static let platform = "platform"
}

extension Suggestion: NodeRepresentable {

    public func makeNode(context: Context) throws -> Node {
        return try Node(node: [
            JSONFields.identifier: identifier.value,
            JSONFields.value: value,
            JSONFields.platform: platform.rawValue
        ])
    }
}
