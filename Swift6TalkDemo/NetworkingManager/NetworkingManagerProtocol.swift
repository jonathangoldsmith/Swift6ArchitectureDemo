//
//  NetworkingManagerProtocol.swift
//  Swift6TalkDemo
//
//  Created by Jonathan Goldsmith on 11/9/25.
//

protocol NetworkingManagerProtocol: Sendable {
  func fetchPosts() async throws -> [PostDTO]
}
