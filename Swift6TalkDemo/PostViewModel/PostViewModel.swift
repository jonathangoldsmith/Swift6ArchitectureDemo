//
//  PostViewModel.swift
//  Swift6TalkDemo
//
//  Created by Jonathan Goldsmith on 11/9/25.
//

import Foundation
import SwiftData
import Combine

@Observable
final class PostViewModel: PostViewModelProtocol {
  private let postActor: PostLocalAlternativeActor
  private let networkingManager: NetworkingManagerProtocol
  let localPersistence: PersistenceLocalAlternativeController

  var isLoading = false
  var errorMessage: String?

  init(networKingManager: NetworkingManagerProtocol = NetworkingManager(), container: ModelContainer) {
    self.localPersistence = PersistenceLocalAlternativeController()
    self.postActor = PostLocalAlternativeActor(localPersistence: self.localPersistence)
    self.networkingManager = networKingManager
  }

  private func beginLoading() {
    isLoading = true
    errorMessage = nil
  }

  func refresh() async {
    beginLoading()

    defer { isLoading = false }

    do {
      let posts = try await networkingManager.fetchPosts()
      try await postActor.refreshPosts(newPosts: posts)
    } catch {
      errorMessage = "Failed to refresh posts: \(error.localizedDescription)"
    }
  }

  func clearAll() async {
    beginLoading()

    defer { isLoading = false }

    do {
      try await postActor.refreshPosts(newPosts: [])
    } catch {
      errorMessage = "Failed to clear posts: \(error.localizedDescription)"
    }
  }
}
