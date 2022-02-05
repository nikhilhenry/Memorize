//
//  MemoryTheme.swift
//  Memorize
//
//  Created by Nikhil Henry on 04/02/22.
//

import Foundation

struct MemoryTheme<CardContent> where CardContent: Hashable{

  private var themes: [Theme] = []
  
  mutating func addTheme(_ theme:Theme){
    themes.append(theme)
  }
  
  func getTheme()->Theme{
    themes[Int.random(in: themes.indices)]
  }
  
  
  struct Theme{
    var name:String
    var emojiSet:[CardContent]
    var numberOfPairsToShow:Int
    var color:String
    
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
