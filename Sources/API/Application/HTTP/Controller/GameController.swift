import HTTP
import Restart
import Domain
import JSON

public struct GameController {
    
    private let getPlatForms: GetPlatforms
    
    init(getPlatForms: GetPlatforms) {
        self.getPlatForms = getPlatForms
    }
    
    func getPlatforms() throws -> ResponseRepresentable {
        do {
            return try JSON(node: getPlatForms.getAll())
        } catch {
            return ServerError.error
        }
    }
}
