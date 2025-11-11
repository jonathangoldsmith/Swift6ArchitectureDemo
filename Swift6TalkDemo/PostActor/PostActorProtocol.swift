//
//  PostActorProtocol.swift
//  Swift6TalkDemo
//
//  Created by Jonathan Goldsmith on 11/9/25.
//

protocol PostActorProtocol {
  func refreshPosts(newPosts: [PostDTO]) async throws
}
