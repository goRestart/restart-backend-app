import ServiceLocator

extension Assembly {

    func getSuggestionDiskModelToDomainMapper() -> SuggestionDiskModelToDomainMapper {
        return SuggestionDiskModelToDomainMapper()
    }
}
