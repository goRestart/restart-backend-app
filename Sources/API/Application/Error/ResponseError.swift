import HTTP
import JSON

private struct JSONKeys {
    static let message: String = "message"
    static let code: String = "code"
}

open class ResponseError {

    static func make(with status: Status, code: Int, message: String) -> Response {
        let json = try! JSON(node: [
            JSONKeys.message: message,
            JSONKeys.code: code
        ])

        return try! Response(status: status, json: json)
    }
}
