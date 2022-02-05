//
//  ContentView.swift
//  Memorize
//
//  Created by Nikhil Henry on 01/02/22.
//

import SwiftUI


struct ContentView: View {
  @ObservedObject var viewModel:EmojiMemoryGame
  
  var body: some View {
    VStack{
      Text("Memorize!").font(.largeTitle).foregroundColor(.black)
      gameMetaView
      ScrollView{
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 65))]){
          ForEach(viewModel.cards){ card in
            CardView(fill:viewModel.themeColor, card: card)
              .aspectRatio(2/3, contentMode: .fit)
              .onTapGesture{
                viewModel.choose(card)
              }
          }
        }
      }
      .padding(.horizontal)
      Button{
        viewModel.startNewGame()
      }label: {
        Text("New Game")
      }.buttonStyle(.borderedProminent)
    }
  }
  var gameMetaView: some View{
    HStack{
      Text("Theme: \(viewModel.currentTheme.name)")
      Spacer()
      Text("Score: \(viewModel.score)")
    }
    .padding()
  }
}

enum ColorOrGradient: ShapeStyle {
case gradient(Gradient)
case color(Color)
}

struct CardView:View{
  let fill:EmojiMemoryGame.ColorOrGradient
  let card: MemoryGame<String>.Card
  var body: some View{
    ZStack{
      let shape = RoundedRectangle(cornerRadius: 20)
      if card.isFaceUp{
        shape.fill(.white)
        switch fill {
        case .gradient(let gradient):
          shape.strokeBorder(LinearGradient(gradient: gradient, startPoint: .top, endPoint: .bottom),lineWidth: 3)
        case .color(let color):
          shape.strokeBorder(color,lineWidth: 3)
        }
        
        Text(card.content).font(.largeTitle)
      }else if card.isMatched{
        shape.opacity(0)
      }
      else{
        switch fill {
        case .gradient(let gradient):
          shape.fill(LinearGradient(gradient: gradient, startPoint: .top, endPoint: .bottom))
        case .color(let color):
          shape.fill(color)
        }
      }
    }
  }
}


struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    let game = EmojiMemoryGame()
    ContentView(viewModel: game)
  }
}
