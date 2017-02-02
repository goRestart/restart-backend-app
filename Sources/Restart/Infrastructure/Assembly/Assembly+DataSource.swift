import ServiceLocator
import Restart

extension Assembly {

    func getSuggestionDiskDataSource() -> SuggestionDataSource {
        return SuggestionDiskDataSource(
            mapper: getSuggestionDiskModelToDomainMapper()
        )
    }
}
