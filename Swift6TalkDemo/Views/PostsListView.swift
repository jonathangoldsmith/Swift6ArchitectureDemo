//
//  PostsListView.swift
//  Swift6TalkDemo
//
//  Created by Jonathan Goldsmith on 11/9/25.
//

import SwiftUI
import SwiftData

struct PostsListView: View {
  let viewModel: PostViewModelProtocol

  var body: some View {
    List(viewModel.localPersistence.posts) { post in
      NavigationLink(value: post) {
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
    .overlay {
      if viewModel.isLoading {
        ProgressView("Loading…")
      }
    }
    .toolbar {
      ToolbarItem(placement: .primaryAction) {
        Button {
          Task { await viewModel.refresh() }
        } label: {
          Label("Refresh", systemImage: "arrow.clockwise")
        }
      }
      ToolbarItem(placement: .navigationBarTrailing) {
        Button(role: .destructive) {
          Task { await viewModel.clearAll() }
        } label: {
          Label("Clear", systemImage: "trash")
        }
      }
    }
    .task {
      await viewModel.refresh()
    }
  }
}

#Preview {
  NavigationStack {
    PostsListView(
      viewModel: PostViewModel(
        container: PersistenceController(inMemory: true).container))
  }
}
