//
//  Good_News_GospelUITests.swift
//  Good News GospelUITests
//
//  Created by Jesse Johnson on 9/4/26.
//

import XCTest

final class Good_News_GospelUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    @MainActor
    func testReadingScreenRendersAndTogglesBookmark() throws {
        let app = XCUIApplication()
        app.launch()

        let gospelName = app.staticTexts["gospelNameLabel"]
        XCTAssertTrue(gospelName.waitForExistence(timeout: 5))
        XCTAssertEqual(gospelName.label, "Gospel of John")

        let momentText = app.staticTexts["gospelMomentText"]
        XCTAssertTrue(momentText.exists)
        XCTAssertEqual(
            momentText.label,
            "Abide in me, and I in you. As the branch cannot bear fruit by itself unless it remains in the vine, so neither can you unless you remain in me. I am the vine. You are the branches."
        )

        let reference = app.staticTexts["scriptureReferenceLabel"]
        XCTAssertTrue(reference.exists)
        XCTAssertEqual(reference.label, "John 15:4–5")

        let bookmarkButton = app.buttons["bookmarkButton"]
        XCTAssertTrue(bookmarkButton.exists)
        XCTAssertEqual(bookmarkButton.value as? String, "Not saved")

        bookmarkButton.tap()
        XCTAssertEqual(bookmarkButton.value as? String, "Saved")

        XCTAssertTrue(app.buttons["keepReadingButton"].exists)
        XCTAssertTrue(app.buttons["doneForNowButton"].exists)
    }

    @MainActor
    func testLaunchPerformance() throws {
        // This measures how long it takes to launch your application.
        measure(metrics: [XCTApplicationLaunchMetric()]) {
            XCUIApplication().launch()
        }
    }
}
