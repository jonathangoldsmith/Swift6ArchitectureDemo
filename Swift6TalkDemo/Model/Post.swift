//
//  post.swift
//  Swift6TalkDemo
//
//  Created by Jonathan Goldsmith on 11/9/25.
//

import Foundation
import SwiftData

@Model
final class Post: Identifiable {
  @Attribute(.unique) var id: Int
  var title: String
  var body: String

  init(id: Int, title: String, body: String) {
    self.id = id
    self.title = title
    self.body = body
  }
}
