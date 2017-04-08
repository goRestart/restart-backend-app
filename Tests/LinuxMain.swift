import XCTest
@testable import RestartTests

XCTMain([

     /* User */
     testCase(EmailValidatorSpec.allTests),
     testCase(PasswordHasherSpec.allTests),
     testCase(VerifyFieldTaskSpec.allTests),
     testCase(AddUserTaskSpec.allTests),

     /* Developer */
     testCase(CheckIfApiKeyIsValidTaskSpec.allTests),

     /* Auth */
     testCase(AuthorizeUserTaskSpec.allTests),
     testCase(SessionRepositorySpec.allTests),
     testCase(InMemorySessionDiskDataSourceSpec.allTests),
     testCase(SessionDiskDataSourceSpec.allTests)
])
