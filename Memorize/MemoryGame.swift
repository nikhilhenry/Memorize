  //
  //  MemoryGame.swift
  //  Memorize
  //
  //  Created by Nikhil Henry on 02/02/22.
  //

import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable{
  private (set) var cards: Array<Card>
  private (set) var score = 0
  
  private var seenCards:[Card] = []
  
  private var indexOfTheOneAndOnlyFaceUpCard:Int?
  
  private var timeSinceLastCard:Date?
  
  mutating func choose(_ card:Card){
    
    
    if let chosenIndex = cards.firstIndex(where: { $0.id == card.id }),
       !cards[chosenIndex].isFaceUp,
       !cards[chosenIndex].isMatched
    {
      if let potentialMatchIndex = indexOfTheOneAndOnlyFaceUpCard{
        if cards[chosenIndex].content  == cards[potentialMatchIndex].content {
          cards[chosenIndex].isMatched = true
          cards[potentialMatchIndex].isMatched = true
          // award point for successful match
          if let timeSinceLastCard = timeSinceLastCard {
            score+=(2 * max(Int(10-timeSinceLastCard.timeIntervalSinceNow),1))
          }
          score+=2
        }
        indexOfTheOneAndOnlyFaceUpCard = nil
      }
      else{
        
        // check if card has previously been seen
        if seenCards.contains(where: {$0.id == card.id}){
          score-=1
        }else{
          // the card has been seen
          seenCards.append(card)
        }
        
        //  make all the cards face down
        for index in cards.indices{
          cards[index].isFaceUp = false
        }
        indexOfTheOneAndOnlyFaceUpCard = chosenIndex
      }
      cards[chosenIndex].isFaceUp.toggle()
      
      timeSinceLastCard = Date()
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
    
      //  shuffle the cards after init
    cards.shuffle()
  }
  
  struct Card: Identifiable{
    var isFaceUp = false
    var isMatched = false
    var content: CardContent
    var id: Int
  }
}
