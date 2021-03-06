  //
  //  MemoryGame.swift
  //  Memorize
  //
  //  Created by Nikhil Henry on 02/02/22.
  //

import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable{
  private (set) var cards: Array<Card>
  
  private var indexOfTheOneAndOnlyFaceUpCard:Int?
  
  mutating func choose(_ card:Card){
    if let chosenIndex = cards.firstIndex(where: { $0.id == card.id }),
       !cards[chosenIndex].isFaceUp,
       !cards[chosenIndex].isMatched
    {
      if let potentialMatchIndex = indexOfTheOneAndOnlyFaceUpCard{
        if cards[chosenIndex].content  == cards[potentialMatchIndex].content {
          cards[chosenIndex].isMatched = true
          cards[potentialMatchIndex].isMatched = true
        }
        indexOfTheOneAndOnlyFaceUpCard = nil
      }
      else{
          //        make all the cards face down
        for index in cards.indices{
          cards[index].isFaceUp = false
        }
        indexOfTheOneAndOnlyFaceUpCard = chosenIndex
      }
      cards[chosenIndex].isFaceUp.toggle()
    }
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
