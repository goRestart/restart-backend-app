import XCTest
@testable import RestartTests

XCTMain([

	/* Suggestion */

     testCase(GetSuggestionsWithQuerySpec.allTests),
     testCase(AddSuggestionSpec.allTests),
     testCase(SuggestionDiskDataSourceSpec.allTests),
     testCase(SuggestionDiskModelToDomainMapperSpec.allTests),

     /* User */

     testCase(EmailValidatorSpec.allTests),
     testCase(PasswordHasherSpec.allTests),
     testCase(VerifyFieldTaskSpec.allTests)
])
