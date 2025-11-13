//
//  PersistenceLocalAlternativeController.swift
//  Swift6TalkDemo
//
//  Created by Jonathan Goldsmith on 11/12/25.
//

import Observation

@MainActor
@Observable
final class PersistenceLocalAlternativeController {
  var posts: [PostDTO] = []
  nonisolated init() { }
}
