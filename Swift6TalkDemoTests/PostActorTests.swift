//
//  PostActorTests.swift
//  Swift6TalkDemoTests
//
//  Created by Jonathan Goldsmith on 11/9/25.
//

import Testing
import SwiftData
@testable import Swift6TalkDemo

@Suite("PostActor Tests")
@MainActor
struct PostActorTests {
  @Test("refreshPosts inserts posts into model context")
  func testRefreshPostsInserts() async throws {
    let container = PersistenceController(inMemory: true).container
    let actor = PostActor(modelContainer: container)
    let posts = [
      PostDTO(id: 1, title: "Title 1", body: "Body 1"),
      PostDTO(id: 2, title: "Title 2", body: "Body 2")
    ]
    try await actor.refreshPosts(newPosts: posts)
    // Await update
    try await Task.sleep(nanoseconds: 20_000_000)
    let fetched = try container.mainContext.fetch(FetchDescriptor<Post>())
    #expect(fetched.count == 2)
    #expect(fetched.contains(where: { $0.title == "Title 1" }))
    #expect(fetched.contains(where: { $0.id == 2 }))
  }

  @Test("refreshPosts clears all posts when passed empty list")
  func testRefreshPostsDeletes() async throws {
    let container = PersistenceController(inMemory: true).container
    let actor = PostActor(modelContainer: container)
    // Pre-populate
    container.mainContext.insert(Post(id: 1, title: "Old", body: "Old"))
    try container.mainContext.save()
    let posts: [PostDTO] = []
    try await actor.refreshPosts(newPosts: posts)
    try await Task.sleep(nanoseconds: 20_000_000)
    let fetched = try container.mainContext.fetch(FetchDescriptor<Post>())
    #expect(fetched.isEmpty)
  }

  @Test("refreshPosts updates existing posts")
  func testRefreshPostsUpdates() async throws {
    let container = PersistenceController(inMemory: true).container
    let actor = PostActor(modelContainer: container)
    let existing = Post(id: 1, title: "Old Title", body: "Old Body")
    container.mainContext.insert(existing)
    try container.mainContext.save()
    let updated = [PostDTO(id: 1, title: "New Title", body: "New Body")]
    try await actor.refreshPosts(newPosts: updated)
    try await Task.sleep(nanoseconds: 20_000_000)
    let fetched = try container.mainContext.fetch(FetchDescriptor<Post>())
    #expect(fetched.count == 1)
    #expect(fetched[0].title == "New Title")
    #expect(fetched[0].body == "New Body")
  }
}
