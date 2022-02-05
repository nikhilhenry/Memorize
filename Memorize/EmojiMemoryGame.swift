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
    themeModel.addTheme(MemoryTheme<String>.Theme(name: "Food", emojiSet: ["🌭","🌭","🍕","🍤","🍗","🌯","🍓","🍔","🍱","🍌"], numberOfPairsToShow: 3, color: "green"))
//  add an additional theme
    themeModel.addTheme(MemoryTheme<String>.Theme(name: "Vehicles", emojiSet: ["🏎","✈️","🚅","🚜","🚁"], numberOfPairsToShow: 4, color: "red"))
    themeModel.addTheme(MemoryTheme<String>.Theme(name: "Test", emojiSet: ["🐧","👻","✏️","🏀 ","🐼 "], numberOfPairsToShow: 5, color: "purple"))
    themeModel.addTheme(MemoryTheme<String>.Theme(name:"Weather",emojiSet: ["☃️","🌨","🌩","⛈","🌧","🌦","☁️","🌬","❄️","🌈","☀️","⛅️","💫","❄️"],numberOfPairsToShow: 6,color: "pink"))
    themeModel.addTheme(MemoryTheme<String>.Theme(name:"Study",emojiSet: ["🧪","📜","📙","📘","📗","📕","📒","📔","📓","📝"],color: "teal"))
    themeModel.addTheme(MemoryTheme<String>.Theme(name:"Mixed",emojiSet: ["😊","🦄","🍤","🌯","🎧","❤️","💭"],color: "gradient"))
    
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
  
  
  enum ColorOrGradient: ShapeStyle {
    case gradient(Gradient)
    case color(Color)
  }
  
  var themeColor: ColorOrGradient {
    switch currentTheme.color.lowercased(){
    case "red": return .color(Color.red)
    case "green": return .color(Color.green)
    case "pink": return .color(Color.pink)
    case "blue": return .color(Color.blue)
    case "cyan": return .color(Color.cyan)
    case "indigo": return .color(Color.cyan)
    case "mint": return .color(Color.mint)
    case "orange": return .color(Color.orange)
    case "purple": return .color(Color.purple)
    case "teal": return .color(Color.teal)
    case "white": return .color(Color.white)
    case "yellow": return .color(Color.yellow)
    case "gradient": return .gradient(Gradient.init(colors: [Color.red,Color.blue]))
    default: return .color(Color.gray)
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


