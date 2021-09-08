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
        .padding(.horizontal)
        .background(Color.white)
        
    }
}

struct ChatBottomView_Previews: PreviewProvider {
    
    static var previews: some View {
        ChatBottomView(user: OtherUser(id: "", name: "Name")).environmentObject(StorageManager())
    }
}
