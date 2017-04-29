import Foundation
import XCTest
import Domain
@testable import Storage

class CheckIfApiKeyIsValidTaskSpec: XCTestDatabasePreparations {

    static let allTests = [
        ("testShould_throw_if_private_key_is_invalid", testShould_throw_if_private_key_is_invalid),
        ("testShould_throw_if_public_key_is_invalid", testShould_throw_if_public_key_is_invalid),
        ("testShould_not_throw_if_keys_are_valid", testShould_not_throw_if_keys_are_valid)
    ]

    private var sut: CheckIfApiKeyIsValidTask!
    private let testPrivateApiKey = "superPrivateApiKey9837493243"
    private let testPublicApiKey = "publicApiKey987987988"

    override func setUp() {
        super.setUp()
        sut = CheckIfApiKeyIsValidTask()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func testShould_throw_if_private_key_is_invalid() {
        givenThereAreValidKeys()

        let invalidPrivateApiKey = "yaTuSabe"

        XCTAssertThrowsError(try sut.execute(invalidPrivateApiKey, testPublicApiKey)) { error in
            XCTAssertEqual(error as? ApiKeyError, ApiKeyError.invalidApiKeys)
        }
    }

    func testShould_throw_if_public_key_is_invalid() {
        givenThereAreValidKeys()

        let invalidPublicApiKey = "palMundo"

        XCTAssertThrowsError(try sut.execute(invalidPublicApiKey, testPublicApiKey)) { error in
            XCTAssertEqual(error as? ApiKeyError, ApiKeyError.invalidApiKeys)
        }
    }

    func testShould_not_throw_if_keys_are_valid() {
        givenThereAreValidKeys()

        try! sut.execute(testPrivateApiKey, testPublicApiKey)
    }

    // MARK - Helpers

    private func givenThereAreValidKeys() {
        let apiKey = ApiKeyDiskModel(
            privateKey: testPrivateApiKey,
            publicKey: testPublicApiKey
        )
        try! apiKey.save()
    }
}
