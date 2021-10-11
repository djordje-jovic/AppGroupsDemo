//
//  ContentView.swift
//  AppGroups
//
//  Created by Djordje Jovic on 8.10.21..
//

import SwiftUI

struct ContentView: View {
    
    @State private var text = AppGroupsData.shared.getText()
    @State private var image = AppGroupsData.shared.getImage()
    @State private var isShowPhotoLibrary = false
    
    var body: some View {
        VStack(alignment: .center, spacing: 10) {
            Text("App groups tutorial!")
                .font(.system(.largeTitle))
                .foregroundColor(.gray)
                .padding(20)
            Text("String".uppercased())
                .font(.system(.caption2))
                .foregroundColor(.black)
            HStack(alignment: .center, spacing: 20) {
                TextField("Title", text: $text)
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
            VStack(alignment: .center, spacing: 10) {
                Text("Image".uppercased())
                    .font(.system(.caption2))
                    .foregroundColor(.black)
                HStack(alignment: .center, spacing: 20) {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: 300, maxHeight: 200, alignment: .center)
                }
                Button(action: {
                                self.isShowPhotoLibrary = true
                            }) {
                                HStack {
                                    Image(systemName: "photo")
                                        .font(.system(size: 20))

                                    Text("Photo library")
                                        .font(.headline)
                                }
                                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 50)
                                .background(.blue)
                                .foregroundColor(.white)
                                .cornerRadius(20)
                                .padding(20)
                            }
            }
        }.sheet(isPresented: $isShowPhotoLibrary) {
            ImagePicker(sourceType: .photoLibrary) { image in
                guard let image = image else { return }
                self.image = image
                AppGroupsData.shared.saveImage(image)
            }
        }.onReceive(NotificationCenter.default.publisher(for: UIApplication.willEnterForegroundNotification)) { _ in
            
            text = AppGroupsData.shared.getText()
            image = AppGroupsData.shared.getImage()
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
