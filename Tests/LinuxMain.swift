import XCTest
@testable import RestartTests

XCTMain([
     testCase(GetSuggestionsWithQuerySpec.allTests),
     testCase(AddSuggestionSpec.allTests),
     testCase(SuggestionDiskDataSourceSpec.allTests),
     testCase(SuggestionDiskModelToDomainMapperSpec.allTests),
     testCase(EmailValidatorSpec.allTests),
     testCase(PasswordHasherSpec.allTests)
])
