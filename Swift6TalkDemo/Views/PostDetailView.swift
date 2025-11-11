//
//  PostDetailView.swift
//  Swift6TalkDemo
//
//  Created by Jonathan Goldsmith on 11/9/25.
//

import SwiftUI

struct PostDetailView: View {
  let post: Post

  var body: some View {
    VStack(alignment: .leading, spacing: 4) {
      Text(post.title)
        .font(.headline)
      Text(post.body)
        .font(.subheadline)
        .foregroundStyle(.secondary)
    }
    .padding(.vertical, 4)
  }
}

#Preview {
  PostDetailView(post: Post(id: 0, title: "Test", body: "Test Body"))
}
