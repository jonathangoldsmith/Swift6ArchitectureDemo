//
//  PostViewModelTests.swift
//  Swift6TalkDemo
//
//  Created by Jonathan Goldsmith on 11/9/25.
//

import Testing
import SwiftData
import XCTest
@testable import Swift6TalkDemo

@Suite("PostViewModel Tests")
@MainActor
struct PostViewModelTests {
  @Test("refresh populates posts from NetworkingManager")
  func testRefreshPopulatesPosts() async throws {
    let container = PersistenceController(inMemory: true).container
    let networking = NetworkingManagerTestable()
    let viewModel = PostViewModel(networKingManager: networking, container: container)

    await viewModel.refresh()
    // Wait a moment to allow persistence changes to propagate
    try await Task.sleep(nanoseconds: 100_000_000)

    let descriptor = FetchDescriptor<Post>()
    let posts = try container.mainContext.fetch(descriptor)
    XCTAssertEqual(posts.count, 3)
    let titles = posts.map { (post: Post) in post.title }.sorted()
    XCTAssertEqual(titles.count, 3)
  }

  @Test("clearAll removes all posts")
  func testClearAllRemovesPosts() async throws {
    let container = PersistenceController(inMemory: true).container
    let networking = NetworkingManagerTestable()
    let viewModel = PostViewModel(networKingManager: networking, container: container)

    await viewModel.refresh()
    try await Task.sleep(nanoseconds: 100_000_000)

    await viewModel.clearAll()
    try await Task.sleep(nanoseconds: 100_000_000)

    let descriptor = FetchDescriptor<Post>()
    let posts = try container.mainContext.fetch(descriptor)
    XCTAssertTrue(posts.isEmpty)
  }

  @Test("refresh sets errorMessage on failure")
  func testRefreshSetsErrorMessageOnFailure() async throws {
    struct FailingNetworkingManager: NetworkingManagerProtocol {
      func fetchPosts() async throws -> [PostDTO] {
        throw NSError(domain: "TestError", code: 1)
      }
    }

    let container = PersistenceController(inMemory: true).container
    let networking = FailingNetworkingManager()
    let viewModel = PostViewModel(networKingManager: networking, container: container)

    await viewModel.refresh()

    XCTAssertNotNil(viewModel.errorMessage)
    XCTAssertTrue(viewModel.errorMessage?.contains("TestError") ?? false)
  }
}
