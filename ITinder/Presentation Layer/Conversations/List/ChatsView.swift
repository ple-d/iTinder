//
//  ChatsView.swift
//  ITinder
//
//  Created by XO on 06.09.2021.
//

import SwiftUI
import SDWebImageSwiftUI

struct ChatsView : View {
    @EnvironmentObject var storageManager: StorageManager
    var search: String
    
    var body : some View{
        List() {
            ForEach(search.isEmpty ? storageManager.chats : storageManager.foundChats) { user in
                NavigationLink(destination: ChatView(user: user).environmentObject(storageManager)) {
                    ChatRow(user : user)
                }
            }
        }
        .padding(.top, 20)
        .background(Color.white)
        .clipShape(shape())
    }
}
