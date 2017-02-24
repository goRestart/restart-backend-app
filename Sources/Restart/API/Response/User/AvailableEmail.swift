import HTTP
import JSON

struct AvailableEmail {
    static let response = try! Response.init(status: .ok, json: JSON([
        "status": "available"
        ])
    )
}
