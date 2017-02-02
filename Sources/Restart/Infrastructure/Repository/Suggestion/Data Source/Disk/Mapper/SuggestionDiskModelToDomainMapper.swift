import Foundation

public struct SuggestionDiskModelToDomainMapper: Mappable {

    public init() {}

    public func map(_ from: SuggestionDiskModel) -> Suggestion {
        let identifier = Identifier(from.id!.string!)
        return Suggestion(
            identifier: identifier,
            value: from.value,
            platform: map(platform: from.platform)
        )
    }

    private func map(platform: Int) -> Platform {
        switch platform {
        case Platform.pc.rawValue: return .pc
        case Platform.nintendo64.rawValue: return .nintendo64
        case Platform.gameboy.rawValue: return .gameboy
        case Platform.playstation.rawValue: return .playstation
        case Platform.gamecube.rawValue: return .gamecube
        case Platform.xbox.rawValue: return .xbox
        case Platform.wii.rawValue: return .wii
        default: return .other
        }
    }
}
