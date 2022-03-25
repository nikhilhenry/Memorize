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
  var color:RGBAColor
  let id:Int
  
  fileprivate init(name: String, emojiSet: [CardContent], numberOfPairsToShow:Int,color:RGBAColor, id: Int) {
    self.name = name
    self.emojiSet = emojiSet
    self.numberOfPairsToShow = numberOfPairsToShow
    self.color = color
    self.id = id
  }
}

class ThemeStore: ObservableObject{
  
  @Published var themes = [Theme<String>]()  {
    didSet {
      storeInUserDefaults()
    }
  }
  
  
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
      insertTheme(name: "Food", emojis:"🌭🌭🍕🍤🍗🌯🍓🍔🍱🍌", numberOfPairsToShow: 3, color: RGBAColor(color: .green),at: 0)
      insertTheme(name: "Vehicles", emojis:"🏎✈️🚅🚜🚁", numberOfPairsToShow: 4, color: RGBAColor(color: .red),at: 1)
      insertTheme(name: "Test", emojis:"🐧👻✏️🏀🐼", numberOfPairsToShow: 5, color: RGBAColor(color: .purple),at: 2)
      insertTheme(name:"Weather",emojis:"☃️🌨🌩⛈🌧🌦☁️🌬❄️🌈☀️⛅️💫❄️",numberOfPairsToShow: 6, color:RGBAColor(color: .pink),at: 3)
      insertTheme(name:"Study",emojis:"🧪📜📘📗📕📒📔📓📝", numberOfPairsToShow: 8,color:RGBAColor(color: .teal),at: 4)
      insertTheme(name:"Mixed",emojis:"😊🦄🍤🌯🎧❤️💭",numberOfPairsToShow:7 ,color: RGBAColor(color: .blue),at: 5)
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
  
  func insertTheme(name:String, emojis:String, numberOfPairsToShow:Int, color:RGBAColor, at index: Int = 0){
    
    let safeId = min(max(index, 0),themes.count)
    
    let emojiSet = Array(Set(emojis.map {String($0)}))
    let cardPairs = min(numberOfPairsToShow,emojiSet.count)
    
    let theme = Theme<String>(name: name, emojiSet:emojiSet, numberOfPairsToShow:cardPairs, color: color, id: safeId)
    
    themes.insert(theme, at: index)
  }
  
}

// Codable Color Implementation

struct RGBAColor: Codable,Hashable,Equatable {
  let red: Double
  let green: Double
  let blue: Double
  let alpha: Double
}
