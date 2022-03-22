//
//  ThemeChooser.swift
//  Memorize
//
//  Created by Nikhil Henry on 21/03/22.
//

import SwiftUI

class ThemeManager: ObservableObject{
  
  typealias Theme = ThemeStore<String>.Theme
  
  private var themeModel: ThemeStore<String>
  
  init(){
    themeModel = ThemeStore()
    
    //  temp add themes
    themeModel.addTheme(Theme(name: "Food", emojiSet: ["🌭","🌭","🍕","🍤","🍗","🌯","🍓","🍔","🍱","🍌"], numberOfPairsToShow: 3, color: "green"))
    themeModel.addTheme(Theme(name: "Vehicles", emojiSet: ["🏎","✈️","🚅","🚜","🚁"], numberOfPairsToShow: 4, color: "red"))
    themeModel.addTheme(Theme(name: "Test", emojiSet: ["🐧","👻","✏️","🏀 ","🐼 "], numberOfPairsToShow: 5, color: "purple"))
    themeModel.addTheme(Theme(name:"Weather",emojiSet: ["☃️","🌨","🌩","⛈","🌧","🌦","☁️","🌬","❄️","🌈","☀️","⛅️","💫","❄️"],numberOfPairsToShow: 6,color: "pink"))
    themeModel.addTheme(Theme(name:"Study",emojiSet: ["🧪","📜","📙","📘","📗","📕","📒","📔","📓","📝"],color: "teal"))
    themeModel.addTheme(Theme(name:"Mixed",emojiSet: ["😊","🦄","🍤","🌯","🎧","❤️","💭"],color: "gradient"))
    
  }
  
  var themes: [Theme]{
    themeModel.themes
  }
  
}
