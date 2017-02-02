import XCTest
@testable import Restart

class AddSuggestionSpec: XCTestCase {

    static let allTests = [
        ("testShould_add_suggestion_if_its_valid", testShould_add_suggestion_if_its_valid)
    ]

    private var sut: AddSuggestion!
    private var getSuggestionsWithQuery: GetSuggestionsWithQuery!
    private var suggestionRepository: SuggestionRepositoryStub!

    override func setUp() {
        super.setUp()

        suggestionRepository = SuggestionRepositoryStub()
        sut = AddSuggestion(
            suggestionRepository: suggestionRepository
        )
        getSuggestionsWithQuery = GetSuggestionsWithQuery(
            suggestionRepository: suggestionRepository
        )
    }

    override func tearDown() {
        suggestionRepository = nil
        sut = nil
        super.tearDown()
    }

    func testShould_add_suggestion_if_its_valid() {
        try? sut.add(suggestion: "Tomb Raider", platform: .pc)

        let suggestions = getSuggestionsWithQuery.get("Tomb Raider")

        XCTAssertEqual(1, suggestions.count)
    }
}
