//
//  ContentView.swift
//  Memorize
//
//  Created by Nikhil Henry on 01/02/22.
//

import SwiftUI

struct ContentView: View {
    //    @todo add more emoijis into the array
  var emojis = ["🏎", "🍤","🚤","🚅"]
  @State var emojiCount = 4
  var body: some View {
    VStack{
      ScrollView{
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 65))]){
          ForEach(emojis[0..<emojiCount],id: \.self){ emoji in
            CardView(content: emoji)
              .aspectRatio(2/3, contentMode: .fit)
          }
        }
      }
      Spacer()
      HStack{
        remove
        Spacer()
        add
      }
      .font(.largeTitle)
      .padding(.horizontal)
      .foregroundColor(.blue)
    }
    .padding(.horizontal)
    .foregroundColor(.red)
  }
  var remove: some View{
    Button(action:{
      if emojiCount <= 1{return}
      emojiCount-=1
    },label:{
      Image(systemName: "minus.circle")
    })
  }
  var add: some View{
    Button(action:{
      if emojiCount == emojis.count {return}
      emojiCount+=1
    },label:{
      Image(systemName: "plus.circle")
    })
  }
}


struct CardView:View{
  var content: String
  @State var isFaceUp: Bool = true
  var body: some View{
    ZStack{
      let shape = RoundedRectangle(cornerRadius: 20)
      if isFaceUp{
        shape.fill().foregroundColor(.white)
        shape.strokeBorder(lineWidth: 3)
        Text(content).font(.largeTitle)
      }else{
        shape.fill()
      }
    }
    .onTapGesture{
      isFaceUp = !isFaceUp
    }
  }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
