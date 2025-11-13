//
//  PostLocalAlternativeActor.swift
//  Swift6TalkDemo
//
//  Created by Jonathan Goldsmith on 11/12/25.
//

import Foundation

actor PostLocalAlternativeActor: PostActorProtocol {
  private let localPersistence: PersistenceLocalAlternativeController

  func refreshPosts(newPosts: [PostDTO]) async throws {
    posts = newPosts
  }

  init(localPersistence: PersistenceLocalAlternativeController) {
    self.localPersistence = localPersistence
  }

  private var updatePosts: Task<Void, Error>?

  private func scheduleUpdatePosts() {
    updatePosts?.cancel()
    updatePosts = Task {
      try? await Task.sleep(nanoseconds: 10_000_000)
      await updatePosts()
    }
  }

  var posts: [PostDTO] = [] {
    didSet {
      scheduleUpdatePosts()
    }
  }

  private func updatePosts() async {
    let currentPosts = self.posts
    await MainActor.run {
      localPersistence.posts = currentPosts
    }
  }
}
