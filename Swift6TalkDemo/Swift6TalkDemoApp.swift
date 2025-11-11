//
//  Swift6TalkDemoApp.swift
//  Swift6TalkDemo
//
//  Created by Jonathan Goldsmith on 11/9/25.
//

import SwiftUI
import SwiftData

@main
struct Swift6TalkDemoApp: App {
  private let sharedPersistenceContainer: ModelContainer = PersistenceController().container
  private let testingPersistenceContainer: ModelContainer = PersistenceController(inMemory: true).container

  var body: some Scene {
    WindowGroup {
      if ProcessInfo.processInfo.arguments.contains("-Testing") || ProcessInfo.processInfo.environment["XCTestConfigurationFilePath"] != nil {
        PostsCoordinator(
          modelContainer: testingPersistenceContainer,
          viewModel: PostViewModelTestable(container: testingPersistenceContainer))
      } else {
        // Normal app launch
        PostsCoordinator(
          modelContainer: sharedPersistenceContainer,
          viewModel: PostViewModel(container: sharedPersistenceContainer))
      }
    }
  }
}
