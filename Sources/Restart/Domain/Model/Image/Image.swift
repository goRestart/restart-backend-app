import Foundation

public enum ImageSize {
    case small
    case medium
    case big
    case original
}

public struct Image {
    let url: URL?
    let size: ImageSize
    let width: Double
    let height: Double
}
