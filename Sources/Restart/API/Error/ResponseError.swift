import HTTP
import JSON

private struct JSONKeys {
    static let message = "message"
    static let code = "code"
}

open class ResponseError {

    static func make(with status: Status, code: Int, message: String) -> Response {
        return try! Response(status: status, json: JSON([
            JSONKeys.message: message.makeNode(),
            JSONKeys.code: code.makeNode()
        ]))
    }
}
