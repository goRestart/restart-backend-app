import XCTest
import Domain
@testable import Storage
@testable import FluentStorage

class GetPrivateKeyTaskSpec: XCTestDatabasePreparations {
    
    static let allTests = [
        ("testShould_throw_error_if_public_api_key_is_invalid", testShould_throw_error_if_public_api_key_is_invalid),
        ("testShould_return_private_api_key_if_found", testShould_return_private_api_key_if_found),
        ("testShould_throw_error_if_api_key_is_disabled", testShould_throw_error_if_api_key_is_disabled)
    ]
    
    private var sut: GetPrivateKeyTask!
    private let testPrivateKey = "myPrivateKey"
    private let testPublicKey = "myPublicKey"
    
    override func setUp() {
        super.setUp()
        
        sut = GetPrivateKeyTask()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func testShould_throw_error_if_public_api_key_is_invalid() {
        XCTAssertThrowsError(try sut.execute("invalidPublicKey")) { (error) in
            XCTAssertEqual(ApiKeyError.invalidApiKeys, error as? ApiKeyError)
        }
    }
    
    func testShould_return_private_api_key_if_found() {
        givenThereArePrivateKeys()
        
        XCTAssertEqual(testPrivateKey, try! sut.execute(testPublicKey))
    }
    
    func testShould_throw_error_if_api_key_is_disabled() {
        givenThereArePrivateKeys(enabled: false)
        
        XCTAssertThrowsError(try sut.execute(testPublicKey)) { (error) in
            XCTAssertEqual(ApiKeyError.invalidApiKeys, error as? ApiKeyError)
        }
    }
    
    // MARK: - Helper
    
    private func givenThereArePrivateKeys(enabled: Bool = true) {
        let privateKey = ApiKeyDiskModel(
            privateKey: testPrivateKey,
            publicKey: testPublicKey,
            enabled: enabled
        )
        try! privateKey.save()
    }
}
