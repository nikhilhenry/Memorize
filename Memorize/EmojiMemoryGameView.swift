//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by Nikhil Henry on 01/02/22.
//

import SwiftUI


struct EmojiMemoryGameView: View {
  @ObservedObject var game:EmojiMemoryGame
  
  var body: some View {
    VStack{
      Text("Memorize!").font(.largeTitle).foregroundColor(.black)
      AspectVGrid(items:game.cards,aspectRatio: 2/3){ card in
        cardView(for: card)
      }
    }
    .padding(.horizontal)
    .foregroundColor(.red)
    }
  
  @ViewBuilder
  private func cardView(for card:EmojiMemoryGame.Card) -> some View {
    if card.isMatched && !card.isFaceUp{
      Rectangle().opacity(0)
    }
    else{
      CardView(card: card)
        .padding(4)
        .onTapGesture {
          game.choose(card)
        }
    }
  }
  
}

struct ThemeView: View{
  var themeIcon: String
  var themeTitle: String
  var themeAction: () -> Void
  var body: some View{
    Button(action:{
      themeAction()
    },label:{
      VStack{
        Image(systemName: themeIcon).font(.largeTitle)
        Text(themeTitle)
          .font(.caption)
      }
      .foregroundColor(.blue)
    })
  }
}


struct CardView:View{
  let card: EmojiMemoryGame.Card
  var body: some View{
    GeometryReader{ geometry in
      ZStack{
        let shape = RoundedRectangle(cornerRadius:drawingConstants.cornerRadius)
        if card.isFaceUp{
          shape.fill().foregroundColor(.white)
          shape.strokeBorder(lineWidth: drawingConstants.lineWidth)
          Pie(
            startAngle: Angle(degrees: 0-90),
            endAngle: Angle(degrees: 360-90),
            clockwise: false
          ).padding(5).opacity(0.5)
          Text(card.content).font(font(in: geometry.size))
        }else if card.isMatched{
          shape.opacity(0)
        }
        else{
          shape.fill()
        }
      }
    }
  }
  
  private func font(in size:CGSize) -> Font{
    .system(size: min(size.width,size.height) * drawingConstants.fontScale)
  }
  
  private struct drawingConstants{
    static let cornerRadius:  CGFloat = 10
    static let lineWidth: CGFloat = 3
    static let fontScale: CGFloat = 0.7
  }
  
}


struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    let game = EmojiMemoryGame()
    game.choose(game.cards.first!)
    return EmojiMemoryGameView(game: game)
  }
}
