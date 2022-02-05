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
    themeModel.addTheme(MemoryTheme<String>.Theme(name: "Food", emojiSet: ["🌭","🌭","🍕","🍤","🍗",], numberOfPairsToShow: 3, color: "green"))
    return themeModel
  }
  
  static func createMemoryGame(theme:MemoryTheme<String>.Theme)->MemoryGame<String>{
    let contents = theme.getThemeContents()
    return MemoryGame<String>(numberOfPairsOfCards:theme.numberOfPairsToShow){ pairIndex in
      contents[pairIndex]
    }
  }
  
  static var themeModel = createThemeModel()
  
  @Published private var model = createMemoryGame(theme: themeModel.getTheme())
  
  var cards: Array<MemoryGame<String>.Card> {
    return model.cards
  }
  
    //  MARK: - Intent(s)
  func choose(_ card:MemoryGame<String>.Card){
    model.choose(card)
  }
}


