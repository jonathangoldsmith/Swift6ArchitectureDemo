//
//  PostsCoordinator.swift
//  Swift6TalkDemo
//
//  Created by Jonathan Goldsmith on 11/9/25.
//

import SwiftUI
import SwiftData

struct PostsCoordinator: View {
  private let modelContainer: ModelContainer
  private let postsViewModel: PostViewModelProtocol

  init(modelContainer: ModelContainer, viewModel: PostViewModelProtocol) {
    self.modelContainer = modelContainer
    self.postsViewModel = viewModel
  }

  var body: some View {
    NavigationStack {
      PostsListView(viewModel: postsViewModel)
        .navigationTitle("Posts")
        .navigationDestination(for: Post.self) { post in
          PostDetailView(post: post)
            .navigationTitle("Cool Post!")
        }
    }
    .modelContainer(modelContainer)
  }
}

#Preview {
  let testablePersistence = PersistenceController(inMemory: true).container
  PostsCoordinator(
    modelContainer: testablePersistence,
    viewModel: PostViewModelTestable(container: testablePersistence))
}
