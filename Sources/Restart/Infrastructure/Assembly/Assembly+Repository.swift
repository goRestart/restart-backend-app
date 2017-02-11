import ServiceLocator

extension Assembly {

    func getSuggestionRepository() -> SuggestionRepositoryProtocol {
        return SuggestionRepository(
            diskDataSource: getSuggestionDiskDataSource()
        )
    }
}
