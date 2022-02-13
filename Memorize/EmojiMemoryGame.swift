//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Nikhil Henry on 02/02/22.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {
  
  typealias Card = MemoryGame<String>.Card
  
  private static let emojis = ["🍔","🌭","🌮","🌯","🥙","🥗","🍕","🍤","🍝","🥐", "🌡","☁️","☀️","🌤","🌥","⛅️","🌦","🌧","⛈","⚡️"]
  
  private static func createMemoryGame()->MemoryGame<String>{
    MemoryGame<String>(numberOfPairsOfCards: 4){ pairIndex in
      EmojiMemoryGame.emojis[pairIndex]
    }
  }
  
  @Published private var model = EmojiMemoryGame.createMemoryGame()
  
  var cards: Array<Card> {
    return model.cards
  }
  
//  MARK: - Intent(s)
  func choose(_ card:Card){
    model.choose(card)
  }
}


