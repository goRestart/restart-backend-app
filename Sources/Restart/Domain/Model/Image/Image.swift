import Foundation

public enum ImageSize: Int {
    case small = 0
    case medium = 1
    case big = 2
    case original = 3
}

public struct Image {
    let identifier: String
    let url: URL?
    let size: ImageSize
    let width: Double
    let height: Double
}
