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
    let stop1 = Gradient.Stop(color: .pink, location: 0.01)
    let stop2 = Gradient.Stop(color: .blue, location: 0.25)
    @State var showProfile = false
    
    var body : some View{
        
        ZStack{
            LinearGradient(
                gradient: Gradient(stops: [stop1, stop2]),
                startPoint: .top,
                endPoint: .bottom).edgesIgnoringSafeArea(.top)
            VStack(spacing: 0){
                
                ChatTopView(user: user, showProfile: $showProfile)
                
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
            .sheet(isPresented: $showProfile, content: {
                // Profile here
            })
        }.onAppear {
            storageManager.msgToRead[user.id] = 0
        }
    }
}

struct ChatView_Previews: PreviewProvider {
    
    static var previews: some View {
        ChatView(user: OtherUser(id: "", name: "Name")).environmentObject(StorageManager())
    }
}
