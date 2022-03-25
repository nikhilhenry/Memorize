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
    // TODO: - Add support for gradient again
    return .color(Color(rgbaColor: currentTheme.color))
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


