//
//  ThemeChooser.swift
//  Memorize
//
//  Created by Nikhil Henry on 21/03/22.
//

import SwiftUI

// The main view to select and display themes at the beginning of the game

struct ThemeChooser: View{
  
  @EnvironmentObject var store: ThemeStore
  
  var body: some View{
    NavigationView {
      List {
        ForEach(store.themes) { theme in
          NavigationLink(destination: EmojiMemoryGameView(game: EmojiMemoryGame(theme: theme)))
          {
            VStack(alignment: .leading){
              Text(theme.name)
              Text(theme.emojiSet[...4].joined())
            }
          }
        }
      }
      .navigationTitle("Memorize")
    }
  }
}

struct ThemeChooser_Previews: PreviewProvider {
  static var previews: some View {
    ThemeChooser().environmentObject(ThemeStore())
  }
}
