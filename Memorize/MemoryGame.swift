//
//  MemoryGame.swift
//  Memorize
//
//  Created by Nikhil Henry on 02/02/22.
//

import Foundation

struct MemoryGame<CardContent>{
  private (set) var cards: Array<Card>
  
  func choose(_ card:Card){
    
  }
  
  init(numberOfPairsOfCards:Int, createCardContent:(Int)->CardContent){
    cards = Array<Card>()
    
//  add numberOfPairsOfCards x 2 cards to cards array
    for pairIndex in 0..<numberOfPairsOfCards{
      let content = createCardContent(pairIndex)
      cards.append(Card(content:content))
      cards.append(Card(content:content))
    }
  }
  
  struct Card{
    var isFaceUp = false
    var isMatched = false
    var content: CardContent
  }
}
