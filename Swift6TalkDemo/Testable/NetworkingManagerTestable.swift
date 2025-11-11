//
//  NetworkingManagerTestable.swift
//  Swift6TalkDemo
//
//  Created by Jonathan Goldsmith on 11/9/25.
//

actor NetworkingManagerTestable: NetworkingManagerProtocol {
  func fetchPosts() async throws -> [PostDTO] {
    return [
      PostDTO(id: 0, title: "Test 0", body: "Test Body 0"),
      PostDTO(id: 1, title: "Test 1", body: "Test Body 1"),
      PostDTO(id: 2, title: "Test 2", body: "Test Body 2")
    ]
  }
}
