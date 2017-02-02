import XCTest
@testable import Restart

class SuggestionDiskDataSourceSpec: XCTestDatabasePreparations {

    static let allTests = [
        ("testShould_add_suggestion", testShould_add_suggestion),
        ("testShould_return_results_if_query_matches", testShould_return_results_if_query_matches),
        ("testShould_return_zero_items_if_query_does_not_match", testShould_return_zero_items_if_query_does_not_match),
        ("testShould_return_zero_items_if_there_are_no_suggestions", testShould_return_zero_items_if_there_are_no_suggestions)
    ]

    private var sut: SuggestionDiskDataSource!
    private var mapper: SuggestionDiskModelToDomainMapper!

    override func setUp() {
        super.setUp()

        prepare(SuggestionDiskModel.self)
        mapper = SuggestionDiskModelToDomainMapper()
        sut = SuggestionDiskDataSource(
            mapper: mapper
        )
    }
    
    override func tearDown() {
        mapper = nil
        sut = nil
        super.tearDown()
    }

    func testShould_add_suggestion() {
        givenThereAreSuggestions()

        let suggestions = sut.get(with: "Super Mario Bros")

        XCTAssertEqual(1, suggestions.count)
    }

    func testShould_return_results_if_query_matches() {
        givenThereAreSuggestions()

        let suggestions = sut.get(with: "Metal")

        XCTAssertEqual(1, suggestions.count)
    }

    func testShould_return_zero_items_if_query_does_not_match() {
        givenThereAreSuggestions()

        let suggestions = sut.get(with: "Power")

        XCTAssertEqual(0, suggestions.count)
    }

    func testShould_return_zero_items_if_there_are_no_suggestions() {
        let suggestions = sut.get(with: "Super")

        XCTAssertEqual(0, suggestions.count)
    }

    // MARK: - Helper 

    private func givenThereAreSuggestions() {
        try! sut.add(suggestion: "Super Mario Bros", platform: .nintendo64)
        try! sut.add(suggestion: "Need for speed Most Wanted", platform: .playstation)
        try! sut.add(suggestion: "Metal Gear", platform: .playstation)
    }
}
