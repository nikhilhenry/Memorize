//
//  ContentView.swift
//  Memorize
//
//  Created by Nikhil Henry on 01/02/22.
//

import SwiftUI

// emoji Collections for themes
let shoppingEmojis = ["⌚️","📱","💻","🖥","💎","💡","🎁","☎️","🔫","🔌"]
let weatherEmojis = ["🌡","☁️","☀️","🌤","🌥","⛅️","🌦","🌧","⛈","⚡️"]
let foodEmojis = ["🍔","🌭","🌮","🌯","🥙","🥗","🍕","🍤","🍝","🥐"]


struct ContentView: View {
  @State var emojis: [String] = shoppingEmojis
  @State var emojiCount = 10
  var body: some View {
    VStack{
      Text("Memorize!").font(.largeTitle).foregroundColor(.black)
      ScrollView{
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 65))]){
          ForEach(emojis[0..<emojiCount],id: \.self){ emoji in
            CardView(content: emoji)
              .aspectRatio(2/3, contentMode: .fit)
          }
        }
      }
      Spacer()
      HStack(){
        ThemeView(themeIcon: "cart.circle", themeTitle: "Shopping")
        { updateEmojis(emojiList: shoppingEmojis)}
        Spacer()
        ThemeView(themeIcon: "sun.max.circle", themeTitle: "Weather")
        { updateEmojis(emojiList: weatherEmojis)}
        Spacer()
        ThemeView(themeIcon: "fork.knife.circle", themeTitle: "Food")
        { updateEmojis(emojiList: foodEmojis)}
      }
      .padding(.horizontal)
    }
    .padding(.horizontal)
    .foregroundColor(.red)
  }
  
  func updateEmojis(emojiList:[String]){
    emojis = emojiList.shuffled()
    // randomise emojiCount
    emojiCount = Int.random(in: 4..<emojiList.count)
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
