import ServiceLocator

extension Assembly {

    func getSuggestionDiskDataSource() -> SuggestionDataSource {
        return SuggestionDiskDataSource(
            mapper: getSuggestionDiskModelToDomainMapper()
        )
    }
}
