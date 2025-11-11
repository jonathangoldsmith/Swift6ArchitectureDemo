//
//  Swift6TalkDemoUITestsLaunchTests.swift
//  Swift6TalkDemoUITests
//
//  Created by Jonathan Goldsmith on 11/9/25.
//

import XCTest

final class Swift6TalkDemoUITestsLaunchTests: XCTestCase {
  
  override class var runsForEachTargetApplicationUIConfiguration: Bool {
    true
  }
  
  override func setUpWithError() throws {
    continueAfterFailure = false
  }
  
  @MainActor
  func testLaunch() throws {
    let app = XCUIApplication()
    app.launchArguments = ["-Testing"]
    app.launch()
    let attachment = XCTAttachment(screenshot: app.screenshot())
    attachment.name = "Launch Screen"
    attachment.lifetime = .keepAlways
    add(attachment)
  }
}
