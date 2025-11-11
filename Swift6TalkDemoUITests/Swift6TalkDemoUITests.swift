//
//  Swift6TalkDemoUITests.swift
//  Swift6TalkDemoUITests
//
//  Created by Jonathan Goldsmith on 11/9/25.
//

import XCTest

final class Swift6TalkDemoUITests: XCTestCase {
  override func setUpWithError() throws {
    // In UI tests it is usually best to stop immediately when a failure occurs.
    continueAfterFailure = false
  }

  @MainActor
  func testExample() throws {
    // UI tests must launch the application that they test.
    let app = XCUIApplication()
    app.launchArguments = ["-Testing"]
    app.launch()

    // Adjust these identifiers/labels to match your app if needed.
    // Prefer accessibility identifiers set in the app code like .accessibilityIdentifier("clearAllButton")
    let clearAllButton = app.buttons["Clear"]
    let refreshButton = app.buttons["Refresh"]

    // Wait for Clear All to appear and tap it
    let existsPredicate = NSPredicate(format: "exists == true && isHittable == true")
    expectation(for: existsPredicate, evaluatedWith: clearAllButton)
    expectation(for: existsPredicate, evaluatedWith: refreshButton)
    waitForExpectations(timeout: 5)

    clearAllButton.tap()

    // Tap Refresh after clearing
    refreshButton.tap()

    // Assuming posts are shown in a table or collection. Update the query as needed.
    // Try common identifiers: a cell with label "PostCell" or the first cell in a table.
    let firstPostCell = app.cells.element(boundBy: 0)
    expectation(for: existsPredicate, evaluatedWith: firstPostCell)
    waitForExpectations(timeout: 5)

    firstPostCell.tap()

    // Verify we navigated to PostDetailView by checking for a known element on that screen.
    let detailTitle = app.staticTexts["Cool Post!"]
    expectation(for: existsPredicate, evaluatedWith: detailTitle)
    waitForExpectations(timeout: 5)

    XCTAssertTrue(detailTitle.exists, "Expected to be on the Post Detail screen after tapping a post.")
  }
}
