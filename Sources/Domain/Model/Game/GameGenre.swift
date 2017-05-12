import Foundation

public struct GameGenre {
    
    public let identifier: String
    public let name: String
    
    public init(identifier: String, name: String) {
        self.identifier = identifier
        self.name = name
    }
}
