//
//  ChatView.swift
//  ITinder
//
//  Created by XO on 06.09.2021.
//

import SwiftUI

struct ChatView: View {
    @EnvironmentObject var storageManager: StorageManager
    let user: OtherUser
    
    var body : some View{
        
        ZStack{
            
            Color(.systemBlue).edgesIgnoringSafeArea(.top)
            
            VStack(spacing: 0){
                
                ChatTopView(user: user)
                
                ScrollViewReader{scrollView in
                    
                    ScrollView(.vertical, showsIndicators: false) {
                        if let messages = storageManager.messages[user.id], !messages.isEmpty {
                            VStack{
                                ForEach(messages){msg in
                                    ChatCell(message: msg)
                                }.onChange(of: messages.count) { item in
                                    if let messages = storageManager.messages[user.id] {
                                        scrollView.scrollTo(messages.last)
                                    }
                                }
                            }
                        } else {
                            HStack {
                                Spacer()
                            }
                        }
                    }.onAppear {
                        if let messages = storageManager.messages[user.id] {
                            scrollView.scrollTo(messages.last)
                        }
                    }
                    .padding(.horizontal, 15)
                    
                }.background(Color.white)
                
                ChatBottomView(user: user).background(Color.white)
                
            }.navigationBarTitle("")
            .navigationBarHidden(true)
        }
    }
}

struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        ChatBottomView(user: OtherUser(id: "", name: "Name"))
    }
}
