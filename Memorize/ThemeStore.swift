//
//  ThemeStore.swift
//  Memorize
//
//  Created by Nikhil Henry on 04/02/22.
//

import Foundation

struct ThemeStore<CardContent> where CardContent: Hashable{
  
  private (set) var themes: [Theme] = []
  
  mutating func addTheme(_ theme:Theme){
    themes.append(theme)
  }
  
  func getRandomTheme()->Theme{
    themes.randomElement()!
  }
  
  
  struct Theme {
    var name:String
    var emojiSet:[CardContent]
    var numberOfPairsToShow:Int
    var color:String
    
    //  the init with numberOfPairsToShow specified
    init(name:String,emojiSet:[CardContent],numberOfPairsToShow:Int,color:String) {
      self.name = name
      self.emojiSet = emojiSet
      self.numberOfPairsToShow = numberOfPairsToShow
      self.color = color
    }
    //  the init without numberOfPairsToShow specified (Extra-credit 2)
    init(name:String,emojiSet:[CardContent],color:String) {
      self.name = name
      self.emojiSet = emojiSet
      self.color = color
      if Int.random(in: 0..<1) == 1{
        numberOfPairsToShow = emojiSet.count
      }else{
        //  show a random number of cards (Extra-credit 2)
        numberOfPairsToShow = Int.random(in: 1..<emojiSet.count)
      }
      
    }
    
    func getThemeContents()->[CardContent]{
      let rawContents = self.emojiSet
      //    get unique list of array items
      let processedContents = Set(rawContents)
      return processedContents.shuffled()
    }
    
    func getNumberOfPairsToShow()->Int{
      let uniqueItems = Set(emojiSet)
      return numberOfPairsToShow > uniqueItems.count ? uniqueItems.count : numberOfPairsToShow
    }
  }
}
