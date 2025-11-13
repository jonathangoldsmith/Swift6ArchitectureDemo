//
//  PostDTO.swift
//  Swift6TalkDemo
//
//  Created by Jonathan Goldsmith on 11/9/25.
//

struct PostDTO: Codable, Identifiable, Hashable {
  let id: Int
  let title: String
  let body: String
}
