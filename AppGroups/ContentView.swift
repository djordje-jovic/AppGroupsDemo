//
//  ContentView.swift
//  AppGroups
//
//  Created by Djordje Jovic on 8.10.21..
//

import SwiftUI

struct ContentView: View {
    
    @State var text = AppGroupsData.shared.getText()
    
    var body: some View {
        VStack(alignment: .center, spacing: 10) {
            Text("App groups tutorial!")
                .font(.system(.largeTitle))
                .foregroundColor(.gray)
                .padding(20)
            HStack(alignment: .center, spacing: 20) {
                TextField("Title", text: $text)
                    .onReceive(NotificationCenter.default.publisher(for: UIApplication.willEnterForegroundNotification)) { _ in
                        
                        text = AppGroupsData.shared.getText()
                    }
                    .disableAutocorrection(true)
                    .padding([.leading, .trailing], 20)
                    .padding([.top, .bottom], 10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(.gray.opacity(0.2), lineWidth: 1)
                    )
                Button("Submit") {
                    dismissKeyboard()
                    AppGroupsData.shared.saveText(text)
                }
            }.padding(EdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20))
        }
    }
    
    private func dismissKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
