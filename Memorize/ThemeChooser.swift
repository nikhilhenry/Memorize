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
          Text(theme.name)
        }
      }
    }
    .navigationTitle("Manage Palettes")
    .navigationBarTitleDisplayMode(.inline)
  }
}

struct ThemeChooser_Previews: PreviewProvider {
  static var previews: some View {
    ThemeChooser()
  }
}
