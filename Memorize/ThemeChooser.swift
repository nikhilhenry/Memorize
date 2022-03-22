//
//  ThemeChooser.swift
//  Memorize
//
//  Created by Nikhil Henry on 21/03/22.
//

import SwiftUI

struct ThemeChooser: View{
  
  @ObservedObject var themeStore: ThemeManager
  
  var body: some View{
    NavigationView {
      List {
        ForEach(themeStore.themes) { theme in
          Text(theme)
        }
      }
    }
    .navigationTitle("Manage Palettes")
    .navigationBarTitleDisplayMode(.inline)
  }
}
