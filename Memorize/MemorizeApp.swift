//
//  MemorizeApp.swift
//  Memorize
//
//  Created by Nikhil Henry on 01/02/22.
//

import SwiftUI

@main
struct MemorizeApp: App {
  let themeStore = ThemeStore()
    var body: some Scene {
        WindowGroup {
          ThemeChooser().environmentObject(themeStore)
        }
    }
}
