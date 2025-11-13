//
//  PostViewModelProtocol.swift
//  Swift6TalkDemo
//
//  Created by Jonathan Goldsmith on 11/9/25.
//

import SwiftData

protocol PostViewModelProtocol {
  init(networKingManager: NetworkingManagerProtocol, container: ModelContainer)
  var isLoading: Bool { get set }
  var errorMessage: String? { get set }
  var localPersistence: PersistenceLocalAlternativeController { get }
  func refresh() async
  func clearAll() async
}
