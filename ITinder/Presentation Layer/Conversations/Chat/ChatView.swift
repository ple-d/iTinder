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
                
                GeometryReader{_ in
                    
                    ScrollView(.vertical, showsIndicators: false) {
                        if let messages = storageManager.messages[user.id], !messages.isEmpty {
                            VStack{
                                ForEach(messages){msg in
                                    ChatCell(message: msg)
                                }
                            }
                        }
                    }
                    .padding(.horizontal, 15)
                    
                    //                    .clipShape(Rounded())
                }.background(Color.white)
                
                ChatBottomView(user: user).background(Color.white)
                
            }
        }
    }
}
