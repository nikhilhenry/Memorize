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
    themeModel.addTheme(MemoryTheme<String>.Theme(name: "Food", emojiSet: ["🌭","🌭","🍕","🍤","🍗",], numberOfPairsToShow: 10, color: "green"))
//  add an additional theme
    themeModel.addTheme(MemoryTheme<String>.Theme(name: "Vehicles", emojiSet: ["🏎","✈️","🚅","🚜","🚁"], numberOfPairsToShow: 10, color: "red"))
//  can add infinte themes
    return themeModel
  }
  
  static func createMemoryGame(theme:MemoryTheme<String>.Theme)->MemoryGame<String>{
    let contents = theme.getThemeContents()
    return MemoryGame<String>(numberOfPairsOfCards:theme.getNumberOfPairsToShow()){ pairIndex in
      contents[pairIndex]
    }
  }
  
  private var themeModel: MemoryTheme<String>
  @Published private var model: MemoryGame<String>
  
  init() {
    themeModel = EmojiMemoryGame.createThemeModel()
    model = EmojiMemoryGame.createMemoryGame(theme: themeModel.getTheme())
  }
  
  
  var cards: Array<MemoryGame<String>.Card> {
    return model.cards
  }
  
  var themeColor: Color {
    switch themeModel.getTheme().color.lowercased(){
    case "red": return Color.red
    case "green": return Color.green
    case "pink": return Color.pink
    case "blue": return Color.blue
    case "cyan": return Color.cyan
    case "indigo": return Color.cyan
    case "mint": return Color.mint
    case "orange": return Color.orange
    case "purple": return Color.purple
    case "teal": return Color.teal
    case "white": return Color.white
    case "yellow": return Color.yellow
    default: return Color.gray
    }
  }
  
    //  MARK: - Intent(s)
  func choose(_ card:MemoryGame<String>.Card){
    model.choose(card)
  }
}


