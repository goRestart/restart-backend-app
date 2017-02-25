import XCTest
@testable import RestartTests

XCTMain([

     /* User */
     testCase(EmailValidatorSpec.allTests),
     testCase(PasswordHasherSpec.allTests),
     testCase(VerifyFieldTaskSpec.allTests),
     testCase(AddUserTaskSpec.allTests),

     /* Developer */
     testCase(CheckIfApiKeyIsValidTask.allTests)
])
