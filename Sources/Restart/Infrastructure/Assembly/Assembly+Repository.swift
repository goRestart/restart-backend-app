import ServiceLocator
import Restart

extension Assembly {

    func getSuggestionRepository() -> SuggestionRepositoryProtocol {
        return SuggestionRepository(
            diskDataSource: getSuggestionDiskDataSource()
        )
    }
}
