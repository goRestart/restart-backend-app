import Node
import Domain

private struct JSONFields {
    static let identifier = "identifier"
    static let name = "name"
}

extension Platform: NodeRepresentable {
    
    public func makeNode(in context: Context?) throws -> Node {
        return try Node(node: [
            JSONFields.identifier: identifier,
            JSONFields.name: name
        ])
    }
}
