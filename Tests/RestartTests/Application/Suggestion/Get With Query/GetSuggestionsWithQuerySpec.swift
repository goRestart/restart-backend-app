import XCTest
@testable import Restart

class GetSuggestionsWithQuerySpec: XCTestCase {

    static let allTests = [
        ("testShould_return_zero_items_when_there_are_no_items", testShould_return_zero_items_when_there_are_no_items),
        ("testShould_return_items_when_filter_matches", testShould_return_items_when_filter_matches)
    ]

    private var sut: GetSuggestionsWithQuery!
    private var suggestionRepository: SuggestionRepositoryStub!

    override func setUp() {
        super.setUp()

        suggestionRepository = SuggestionRepositoryStub()
        sut = GetSuggestionsWithQuery(
            suggestionRepository: suggestionRepository
        )
    }
    
    override func tearDown() {
        suggestionRepository = nil
        sut = nil
        super.tearDown()
    }

    func testShould_return_zero_items_when_there_are_no_items() {
        givenThereAreZeroSuggestions()

        let suggestions = sut.get("xbox")

        XCTAssertEqual(0, suggestions.count)
    }

    func testShould_return_items_when_filter_matches() {
        givenThereAreSuggestions()

        let suggestions = sut.get("xbox")

        XCTAssertEqual(1, suggestions.count)
    }


    // MARK: - Helper

    private func givenThereAreZeroSuggestions() {
        suggestionRepository.suggestions = []
    }

    private func givenThereAreSuggestions() {
        let suggestions = [
            Suggestion(identifier: Identifier.make(), value: "Xbox", platform: .xbox),
            Suggestion(identifier: Identifier.make(), value: "Playstation", platform: .playstation)
        ]
        suggestionRepository.suggestions = suggestions
    }
}
