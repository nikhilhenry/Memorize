//
//  ThemeEditor.swift
//  Memorize
//
//  Created by Nikhil Henry on 25/03/22.
//

import SwiftUI

struct ThemeEditor: View {
  
  @Binding var theme:Theme<String>
  
  @EnvironmentObject var store: ThemeStore
  
  @Environment(\.presentationMode) var presentationMode
  
  var body: some View{
    NavigationView{
      editorForm
        .navigationTitle("Theme Editor")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar{
          ToolbarItem(placement: .navigationBarLeading){
            if presentationMode.wrappedValue.isPresented, UIDevice.current.userInterfaceIdiom != .pad {
              Button("Close"){
                presentationMode.wrappedValue.dismiss()
              }
            }
          }
        }
    }
  }
  
  var editorForm: some View{
    Form {
      nameSection
      addEmojisSection
      removeEmojisSection
    }
  }
  // Form components
  var nameSection: some View{
    Section(header: Text("Name")){
      TextField("Name",text: $theme.name)
    }
  }
  
  @State private var emojisToAdd = ""
  
  var addEmojisSection: some View{
    Section(header: Text("Add Emojis")){
      TextField("Name",text: $emojisToAdd)
        .onChange(of: emojisToAdd) {emojis in
          addEmojis(emojis)
        }
    }
  }
  
  private func addEmojis(_ emojis:String){
    withAnimation{
      theme.emojiSet.append(contentsOf: Set(emojis.map{String($0)}))
    }
  }
  
  var removeEmojisSection: some View{
    Section(header: Text("Remove Emoji")){
      let emojis = theme.emojiSet
      LazyVGrid(columns: [GridItem(.adaptive(minimum: 40))]){
        ForEach(emojis, id:\.self){ emoji in
          Text(emoji)
            .onTapGesture {
              withAnimation{
                theme.emojiSet.removeAll(where:{$0 == emoji})
              }
            }
        }
      }
      .font(.system(size: 40))
    }
  }
}

//struct ThemeEditor_Previews: PreviewProvider {
//  static var previews: some View {
//    private var theme = ThemeStore().theme(at: 0)
//    ThemeEditor(theme: theme)
//  }
//}
