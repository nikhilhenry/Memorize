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
      ScrollView{
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 100))]){
          ForEach(game.cards){ card in
            CardView(card: card)
              .aspectRatio(2/3, contentMode: .fit)
              .onTapGesture{
                game.choose(card)
              }
          }
        }
      }
      .padding(.horizontal)
      .foregroundColor(.red)
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
    static let cornerRadius:  CGFloat = 20
    static let lineWidth: CGFloat = 3
    static let fontScale: CGFloat = 0.8
  }
  
}


struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    let game = EmojiMemoryGame()
    EmojiMemoryGameView(game: game)
  }
}
