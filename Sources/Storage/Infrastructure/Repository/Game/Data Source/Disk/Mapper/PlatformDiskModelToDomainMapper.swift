import Foundation
import Shared
import FluentStorage
import Domain

struct PlatformDiskModelToDomainMapper: Mappable{
    
    func map(_ from: PlatformDiskModel) -> Platform {
        return Platform(
            identifier: from.id!.string!,
            name: from.name
        )
    }
}
