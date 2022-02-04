//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Nikhil Henry on 02/02/22.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {
  
  static let emojis =  ["🌡","☁️","☀️","🌤","🌥","⛅️","🌦","🌧","⛈","⚡️"]
  
  static let foodTheme = MemoryTheme<String>.Theme(name: "Food", emojiSet: ["🍔","🌭","🌮","🌯","🥙","🥗","🍕","🍤","🍝","🥐"], numberOfPairsToShow: 3, color: "green")
  
  static func createTheme(_ theme:MemoryTheme<String>.Theme)->MemoryTheme<String>{
    var themeModel = MemoryTheme<String>()
    themeModel.addTheme(theme)
    return themeModel
  }
  
  static func createMemoryGame()->MemoryGame<String>{
    MemoryGame<String>(numberOfPairsOfCards: 4){ pairIndex in
      EmojiMemoryGame.emojis[pairIndex]
    }
  }
  
  private var themeModel: MemoryTheme<String> = createTheme(foodTheme)
  
  @Published private var model: MemoryGame<String> = EmojiMemoryGame.createMemoryGame()
  
  var cards: Array<MemoryGame<String>.Card> {
    return model.cards
  }
  
//  MARK: - Intent(s)
  func choose(_ card:MemoryGame<String>.Card){
    model.choose(card)
  }
}


