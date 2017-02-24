import HTTP
import JSON

struct AvailableUsername {
    static let response = try! Response.init(status: .ok, json: JSON([
        "status": "available"
        ])
    )
}
