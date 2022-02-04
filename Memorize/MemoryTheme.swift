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
  
  struct Theme{
    var name:String
    var emojiSet:[CardContent]
    var numberOfPairsToShow:Int
    var color:String
  }
}
