import Foundation

public struct GameCompany {
    
    public let identifier: String
    public let name: String
    public let description: String?
    
    public init(identifier: String,
                name: String,
                description: String?)
    {
        self.identifier = identifier
        self.name = name
        self.description = description
    }
}
