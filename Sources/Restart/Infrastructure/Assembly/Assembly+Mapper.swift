import ServiceLocator
import Restart

extension Assembly {

    func getSuggestionDiskModelToDomainMapper() -> SuggestionDiskModelToDomainMapper {
        return SuggestionDiskModelToDomainMapper()
    }
}
