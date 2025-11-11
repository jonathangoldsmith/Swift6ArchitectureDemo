//
//  NetworkingManager.swift
//  Swift6TalkDemo
//
//  Created by Jonathan Goldsmith on 11/9/25.
//

import Foundation
import SwiftData

actor NetworkingManager: NetworkingManagerProtocol {
  private let endpointURL: URL = URL(string: "https://jsonplaceholder.typicode.com/posts")!
  private let decoder: JSONDecoder = .init()

  func fetchPosts() async throws -> [PostDTO] {
    let (data, response) = try await URLSession.shared.data(from: endpointURL)
    guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
      throw URLError(.badServerResponse)
    }
    return try decoder.decode([PostDTO].self, from: data)
  }
}
