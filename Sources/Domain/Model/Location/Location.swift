import Foundation

public typealias Coordinate = (latitude: Double, longitude: Double)

public struct Location {
    
    public let coordinate: Coordinate?
    public let city: String?
    public let country: String?
    public let zip: String?
    public let ip: String?
    
    public init(coordinate: Coordinate?,
                city: String?,
                country: String?,
                zip: String?,
                ip: String?)
    {
        self.coordinate = coordinate
        self.city = city
        self.country = country
        self.zip = zip
        self.ip = ip
    }
}
