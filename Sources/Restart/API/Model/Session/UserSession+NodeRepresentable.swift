import Node
import Fluent

private struct JSONFields {
    static let token = "token"
    static let validUntil = "valid_until"
}

extension UserSession: NodeRepresentable {

    public func makeNode(context: Context) throws -> Node {
        return try Node(node: [
            JSONFields.token: token.makeNode(),
            JSONFields.validUntil: validUntil.mysql
        ])
    }
}
