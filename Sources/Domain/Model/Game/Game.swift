import Foundation

public struct Game {
    
    public let identifier: String
    public let title: String
    public let alternativeNames: [String]
    public let description: String
    public let images: [Image]
    public let company: GameCompany?
    public let platforms: [Platform]
    public let genres: [GameGenre]
    public let released: Date
    
    public init(identifier: String,
                title: String,
                alternativeNames: [String],
                description: String,
                images: [Image],
                company: GameCompany?,
                platforms: [Platform],
                genres: [GameGenre],
                released: Date)
    {
        self.identifier = identifier
        self.title = title
        self.alternativeNames = alternativeNames
        self.description = description
        self.images = images
        self.company = company
        self.platforms = platforms
        self.genres = genres
        self.released = released
    }
}
