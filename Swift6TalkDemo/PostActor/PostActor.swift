//
//  PostActor.swift
//  Swift6TalkDemo
//
//  Created by Jonathan Goldsmith on 11/9/25.
//

import SwiftData
import Foundation

@ModelActor
actor PostActor: PostActorProtocol {
  func refreshPosts(newPosts: [PostDTO]) async throws {
    posts = newPosts
    try scheduleUpdatePosts()
  }

  private var updatePosts: Task<Void, Error>?

  private func scheduleUpdatePosts() throws {
    updatePosts?.cancel()
    updatePosts = Task {
      try? await Task.sleep(nanoseconds: 10_000_000)
      try await updatePosts()
    }
  }

  var posts: [PostDTO] = []
  
  private func updatePosts() async throws {
    if posts.isEmpty {
      let allPosts = try modelExecutor.modelContext.fetch(FetchDescriptor<Post>())
      for post in allPosts {
        modelExecutor.modelContext.delete(post)
      }
    } else {
      for post in posts {
        let fetch = FetchDescriptor<Post>(predicate: #Predicate { $0.id == post.id })
        if let existing = try modelExecutor.modelContext.fetch(fetch).first {
          existing.title = post.title
          existing.body = post.body
        } else {
          modelExecutor.modelContext.insert(Post(id: post.id, title: post.title, body: post.body))
        }
      }
    }
    try modelExecutor.modelContext.save()
  }
}

