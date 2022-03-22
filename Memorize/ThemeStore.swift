//
//  ThemeStore.swift
//  Memorize
//
//  Created by Nikhil Henry on 04/02/22.
//

import SwiftUI

// a simple, persistent storage place for Themes

struct Theme<CardContent>:Identifiable,Codable where CardContent: Codable{
  var name:String
  var emojiSet:[CardContent]
  var numberOfPairsToShow:Int
  var color:String
  let id:Int
  
  fileprivate init(name: String, emojiSet: [CardContent], numberOfPairsToShow:Int,color:String, id: Int) {
    self.name = name
    self.emojiSet = emojiSet
    self.numberOfPairsToShow = numberOfPairsToShow
    self.color = color
    self.id = id
  }
}

class ThemeStore{
  
  @Published var themes = [Theme<String>]()
  
  // MARK: - Persistence Handling
  
  private let userDefaultsKey = "ThemeStore"
  
  private func storeInUserDefaults(){
    UserDefaults.standard.set(try? JSONEncoder().encode(themes), forKey: userDefaultsKey)
  }
  
  private func restoreFromUserDefaults(){
    if let jsonData = UserDefaults.standard.data(forKey: userDefaultsKey){
      if let decodedThemes = try? JSONDecoder().decode([Theme<String>].self,from: jsonData){
        themes = decodedThemes
      }
    }
  }
  
  init(){
    restoreFromUserDefaults()
    if themes.isEmpty{
      // add default themes
      insertTheme(name: "Food", emojiSet: ["🌭","🌭","🍕","🍤","🍗","🌯","🍓","🍔","🍱","🍌"], numberOfPairsToShow: 3, color: "green")
      insertTheme(name: "Vehicles", emojiSet: ["🏎","✈️","🚅","🚜","🚁"], numberOfPairsToShow: 4, color: "red")
      insertTheme(name: "Test", emojiSet: ["🐧","👻","✏️","🏀 ","🐼 "], numberOfPairsToShow: 5, color: "purple")
      insertTheme(name:"Weather",emojiSet: ["☃️","🌨","🌩","⛈","🌧","🌦","☁️","🌬","❄️","🌈","☀️","⛅️","💫","❄️"],numberOfPairsToShow: 6,color: "pink")
      insertTheme(name:"Study",emojiSet: ["🧪","📜","📙","📘","📗","📕","📒","📔","📓","📝"], numberOfPairsToShow: 8,color: "teal")
      insertTheme(name:"Mixed",emojiSet: ["😊","🦄","🍤","🌯","🎧","❤️","💭"],numberOfPairsToShow:7 ,color: "gradient")
    }
  }
  
  
  // MARK: - Intents
  
  
  func theme(at index: Int) -> Theme<String> {
    let safeIndex = min(max(index, 0), themes.count - 1)
    return themes[safeIndex]
  }
  
  @discardableResult
  func removeTheme(at index: Int) -> Int {
    if themes.count > 1, themes.indices.contains(index) {
      themes.remove(at: index)
    }
    return index % themes.count
  }
  
  func insertTheme(name:String, emojiSet:[String], numberOfPairsToShow:Int, color:String, at index: Int = 0){
    
    let safeId = min(max(index, 0),themes.count)
    
    let theme = Theme<String>(name: name, emojiSet: emojiSet, numberOfPairsToShow: numberOfPairsToShow, color: color, id: safeId)
    
    themes.insert(theme, at: index)
  }
  
}
