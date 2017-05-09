import XCTest
@testable import StorageTests

private let storageTests = [
     /* Infrastructure */
     testCase(UserSessionRepositorySpec.allTests),
     testCase(InMemoryUserSessionDiskDataSourceSpec.allTests),

     /* Tasks */
     testCase(CheckIfApiKeyIsValidTaskSpec),
     testCase(AuthorizeUserTaskSpec.allTests),
     testCase(GetPrivateKeyTaskSpec.allTests),
     testCase(AddUserTaskSpec.allTests),
     testCase(VerifyFieldTaskSpec.allTests),

     /* Utils */
     testCase(PasswordHasherSpec.allTests),
     testCase(EmailValidatorSpec.allTests)
] 

let allTests = storageTests

XCTMain(allTests)