//
//  PostViewModelTestable.swift
//  Swift6TalkDemo
//
//  Created by Jonathan Goldsmith on 11/9/25.
//

import SwiftData

final class PostViewModelTestable: PostViewModelProtocol {
  var localPersistence: PersistenceLocalAlternativeController
  
  private let postActor: PostActorProtocol
  private let networkingManager: NetworkingManagerProtocol

  init(networKingManager: any NetworkingManagerProtocol = NetworkingManagerTestable(), container: ModelContainer) {
    self.networkingManager = networKingManager
    self.postActor = PostActor(modelContainer: container)
    self.localPersistence = PersistenceLocalAlternativeController()
  }
  
  var isLoading: Bool = false
  var errorMessage: String?
  
  func refresh() async {
    let posts = try! await networkingManager.fetchPosts()
    try? await postActor.refreshPosts(newPosts: posts)
  }
  
  func clearAll() async {
    try? await postActor.refreshPosts(newPosts: [])
  }
}
