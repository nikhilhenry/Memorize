//
//  MemoryTheme.swift
//  Memorize
//
//  Created by Nikhil Henry on 04/02/22.
//

import Foundation

struct MemoryTheme<CardContent>{

  private var themes: [Theme] = []
  
  mutating func addTheme(_ theme:Theme){
    themes.append(theme)
  }
  
  func getThemeContents()->[CardContent]{
    let theme = themes[Int.random(in: themes.indices)]
    let contents = theme.emojiSet.shuffled()
    return contents
  }
  
  struct Theme{
    var name:String
    var emojiSet:[CardContent]
    var numberOfPairsToShow:Int
    var color:String
  }
}
