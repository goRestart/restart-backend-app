import Node

private struct JSONFields {
    static let token = "token"
    static let validUntil = "valid_until"
}

extension UserSession: NodeRepresentable {

    public func makeNode(in context: Context?) throws -> Node {
        return try Node(node: [
            JSONFields.token: token.makeNode(in: context),
            JSONFields.validUntil: validUntil
        ])
    }
}
