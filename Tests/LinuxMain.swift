import XCTest
@testable import StorageTests

XCTMain([

     testCase(PasswordHasherSpec.allTests),
     testCase(EmailValidatorSpec.allTests)
     # /* User */
     # testCase(EmailValidatorSpec.allTests),
     # testCase(PasswordHasherSpec.allTests),
     # testCase(VerifyFieldTaskSpec.allTests),
     # testCase(AddUserTaskSpec.allTests),

     # /* Developer */
     # testCase(CheckIfApiKeyIsValidTaskSpec.allTests),

     # /* Auth */
     # testCase(AuthorizeUserTaskSpec.allTests),
     # testCase(SessionRepositorySpec.allTests),
     # testCase(InMemorySessionDiskDataSourceSpec.allTests),
     # testCase(SessionDiskDataSourceSpec.allTests)
])
