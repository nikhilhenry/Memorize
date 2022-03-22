//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Nikhil Henry on 02/02/22.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {
  
  static let emojis =  ["🌡","☁️","☀️","🌤","🌥","⛅️","🌦","🌧","⛈","⚡️"]
  
  typealias Card = MemoryGame<String>.Card

  static func createMemoryGame(theme:Theme<String>)->MemoryGame<String>{
    let contents = theme.emojiSet
    return MemoryGame<String>(numberOfPairsOfCards:theme.numberOfPairsToShow){ pairIndex in
      contents[pairIndex]
    }
  }
  
  private (set) var currentTheme: Theme<String>
  @Published private var model: MemoryGame<String>
  var isDealt = false
  
  init(theme: Theme<String>) {
    currentTheme = theme
    model = EmojiMemoryGame.createMemoryGame(theme:currentTheme)
  }
  
  
  var cards: Array<Card> {
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
    case "gradient": return .gradient(Gradient.init(colors: [Color("Timber2"),Color("Timber1")]))
    default: return .color(Color.gray)
    }
  }
  
  //  MARK: - Intent(s)
  func choose(_ card:Card){
    model.choose(card)
  }
  
  func shuffle(){
    model.shuffle()
  }
  
  func restart(){
    //  reset game model
    model = EmojiMemoryGame.createMemoryGame(theme:currentTheme)
  }
}


