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
  
  @State private var games: [Int: EmojiMemoryGame] = [:]
  
  @State private var editMode:EditMode = .inactive
  
  var body: some View{
    NavigationView {
      List {
        ForEach(store.themes) { theme in
          NavigationLink(destination: NavigationLazyView(loadGame(themeId: theme.id)))
          {
            VStack(alignment: .leading){
              Text(theme.name)
              Text(theme.emojiSet.joined())
            }
            .gesture(editMode == .active ? tap:nil)
          }
        }
        .onDelete { indexSet in
          store.themes.remove(atOffsets: indexSet)
        }
        .onMove { indexSet, newOffset in
          store.themes.move(fromOffsets: indexSet, toOffset: newOffset)
        }
      }
      .navigationTitle("Memorize")
      .toolbar {
        ToolbarItem {EditButton()}
      }
      .environment(\.editMode, $editMode)
    }
  }
  
  private var tap: some Gesture{
    TapGesture().onEnded {}
  }
  
  private func loadGame(themeId: Int) -> EmojiMemoryGameView{
    if let game = games[themeId]{
      print("loading existing game")
      return EmojiMemoryGameView(game: game)
    }
    else {
      print("creating new game")
      let game = EmojiMemoryGame(theme: store.theme(at: themeId))
      games[themeId] = game
      return EmojiMemoryGameView(game: game)
    }
  }
}

struct NavigationLazyView<Content: View>: View {
  let build: () -> Content
  init(_ build: @autoclosure @escaping () -> Content) {
    self.build = build
  }
  var body: Content {
    build()
  }
}

// Codable Color Representations

extension Color {
  init(rgbaColor rgba: RGBAColor) {
    self.init(.sRGB, red: rgba.red, green: rgba.green, blue: rgba.blue, opacity: rgba.alpha)
  }
}

extension RGBAColor {
  init(color: Color) {
    var red: CGFloat = 0
    var green: CGFloat = 0
    var blue: CGFloat = 0
    var alpha: CGFloat = 0
    UIColor(color).getRed(&red, green: &green, blue: &blue, alpha: &alpha)
    self.init(red: Double(red), green: Double(green), blue: Double(blue), alpha: Double(alpha))
  }
}

struct ThemeChooser_Previews: PreviewProvider {
  static var previews: some View {
    ThemeChooser().environmentObject(ThemeStore())
  }
}
