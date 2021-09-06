//
//  ChatBottomView.swift
//  ITinder
//
//  Created by XO on 06.09.2021.
//

import SwiftUI

struct ChatBottomView : View {
    @EnvironmentObject var storageManager: StorageManager
    @State var txt = ""
    let user: OtherUser
    
    var body : some View{
        HStack(spacing: 15){
            TextField("Введите Ваше сообщение", text: $txt).padding(.horizontal).frame(height: 45).background(Color.primary.opacity(0.06)).clipShape(Capsule())
            if txt != "" {
                Button(action: {storageManager.sendMessage(chatId: user.id, message: Message(msg: txt, user: self.storageManager.currentUser?.id ?? "", timeStamp: Date()))
                    txt = ""
                }) {
                    Image(systemName: "paperplane.fill").font(.system(size: 22)).foregroundColor(.white).frame(width: 45, height: 45).background(Color.blue).clipShape(Circle())
                }
            }
        }
        .background(Color.white)
        .padding(.horizontal)
//        HStack{
//
//            HStack(spacing : 8){
//
//                Button(action: {
//
//                }) {
//
//                    Image("emoji").resizable().frame(width: 20, height: 20)
//
//                }.foregroundColor(.gray)
//
//                TextField("Type Something", text: $txt)
//
//                Button(action: {
//
//                }) {
//
//                    Image(systemName: "camera.fill").font(.body)
//
//                }.foregroundColor(.gray)
//
//                Button(action: {
//
//                }) {
//
//                    Image(systemName: "paperclip").font(.body)
//
//                }.foregroundColor(.gray)
//
//            }.padding()
//            .background(Color(.blue))
//            .clipShape(Capsule())
//
//            Button(action: {
//
//            }) {
//
//                Image(systemName: "mic.fill")
//                    .resizable()
//                    .frame(width: 15, height: 23)
//                    .padding(13)
//                    .foregroundColor(.white)
//                    .background(Color(.blue))
//                    .clipShape(Circle())
//
//            }.foregroundColor(.gray)
//
//        }.padding(.horizontal, 15)
//        .background(Color.white)
        
    }
}
