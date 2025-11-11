//
//  PersistenceController.swift
//  Swift6TalkDemo
//
//  Created by Jonathan Goldsmith on 11/9/25.
//

import SwiftData

struct PersistenceController {
  let container: ModelContainer

  init(inMemory: Bool = false) {
    let schema = Schema([Post.self])
    let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: inMemory)

    do {
      container = try ModelContainer(for: schema, configurations: [modelConfiguration])
    } catch {
      fatalError("Could not create ModelContainer: \(error)")
    }
  }
}
