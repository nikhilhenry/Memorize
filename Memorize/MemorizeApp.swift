//
//  MemorizeApp.swift
//  Memorize
//
//  Created by Nikhil Henry on 01/02/22.
//

import SwiftUI

@main
struct MemorizeApp: App {
  let game = EmojiMemoryGame()
    var body: some Scene {
        WindowGroup {
          EmojiMemoryGameView(viewModel: game)
        }
    }
}
