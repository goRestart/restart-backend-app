import HTTP
import JSON

struct SuccessfullyCreated {
    static let response = try! Response(status: .created, json: JSON("ok"))
}
