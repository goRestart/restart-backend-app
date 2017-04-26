import XCTest
@testable import StorageTests

private let storageTests = [
     /* Infrastructure */
     testCase(UserSessionRepositorySpec.allTests),
     testCase(InMemoryUserSessionDiskDataSourceSpec.allTests),

     /* Utils */
     testCase(PasswordHasherSpec.allTests),
     testCase(EmailValidatorSpec.allTests)
] 

let allTests = storageTests

XCTMain(allTests)