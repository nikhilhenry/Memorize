  //
  //  EmojiMemoryGame.swift
  //  Memorize
  //
  //  Created by Nikhil Henry on 02/02/22.
  //

import SwiftUI

class EmojiMemoryGame: ObservableObject {
  
  static let emojis =  ["🌡","☁️","☀️","🌤","🌥","⛅️","🌦","🌧","⛈","⚡️"]
  
  static func createThemeModel()->MemoryTheme<String>{
    var themeModel = MemoryTheme<String>()
    themeModel.addTheme(MemoryTheme<String>.Theme(name: "Food", emojiSet: ["🍔","🌭","🌮","🌯","🥙","🥗","🍕","🍤","🍝","🥐"], numberOfPairsToShow: 4, color: "green"))
    return themeModel
  }
  
  static func createMemoryGame(content:[String])->MemoryGame<String>{
    MemoryGame<String>(numberOfPairsOfCards: 4){ pairIndex in
      content[pairIndex]
    }
  }
  
  static var themeModel = createThemeModel()
  
  @Published private var model = createMemoryGame(content: themeModel.getThemeContents())
  
  var cards: Array<MemoryGame<String>.Card> {
    return model.cards
  }
  
    //  MARK: - Intent(s)
  func choose(_ card:MemoryGame<String>.Card){
    model.choose(card)
  }
}


