//
//  MemoryGame.swift
//  Memorize
//
//  Created by Nikhil Henry on 02/02/22.
//

import Foundation

struct MemoryGame<CardContent>{
  private (set) var cards: Array<Card>
  
  mutating func choose(_ choosenCard:Card){
    let chosenIndex = cards.firstIndex{card in card.id == choosenCard.id}
    cards[chosenIndex!].isFaceUp.toggle()
  }
  
  init(numberOfPairsOfCards:Int, createCardContent:(Int)->CardContent){
    cards = Array<Card>()
    
//  add numberOfPairsOfCards x 2 cards to cards array
    for pairIndex in 0..<numberOfPairsOfCards{
      let content = createCardContent(pairIndex)
      cards.append(Card(content:content, id: 2*pairIndex))
      cards.append(Card(content:content,id: 2*pairIndex + 1))
    }
  }
  
  struct Card: Identifiable{
    var isFaceUp = false
    var isMatched = false
    var content: CardContent
    var id: Int
  }
}
