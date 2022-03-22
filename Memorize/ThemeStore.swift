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
  
  
  // MARK: - Intents
  
  func addTheme(_ theme:Theme<String>){
    themes.append(theme)
  }
  
}
