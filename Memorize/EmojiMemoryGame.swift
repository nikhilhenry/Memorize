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
//  add an additional theme
    themeModel.addTheme(MemoryTheme<String>.Theme(name: "Vehicles", emojiSet: ["🏎","✈️","🚅","🚜","🚁"], numberOfPairsToShow: 4, color: "red"))
    themeModel.addTheme(MemoryTheme<String>.Theme(name: "Test", emojiSet: ["🐧","👻","✏️","🏀 ","🐼 "], numberOfPairsToShow: 5, color: "purple"))
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
  private (set) var currentTheme: MemoryTheme<String>.Theme
  @Published private var model: MemoryGame<String>
  
  init() {
    themeModel = EmojiMemoryGame.createThemeModel()
    currentTheme = themeModel.getRandomTheme()
    model = EmojiMemoryGame.createMemoryGame(theme:currentTheme)
  }
  
  
  var cards: Array<MemoryGame<String>.Card> {
    return model.cards
  }
  
  var score: Int {
    return model.score
  }
  
  var themeColor: Color {
    switch currentTheme.color.lowercased(){
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
  
  func startNewGame(){
//  reset theme and model
    currentTheme = themeModel.getRandomTheme()
    model = EmojiMemoryGame.createMemoryGame(theme:currentTheme)
  }
}


