//
//  ChatCell.swift
//  ITinder
//
//  Created by XO on 06.09.2021.
//

import SwiftUI

struct ChatCell : View {
    @EnvironmentObject var storageManager: StorageManager
    var message : Message
    
    var body : some View {
        HStack{
            if message.user == storageManager.currentUser?.id {
                Spacer()
                Text(message.msg)
                    .padding()
                    .background(Color(.brown))
                    .clipShape(msgTail(userMsg: message.user == storageManager.currentUser?.id))
                    .foregroundColor(Color.white)
            }
            else{
                Text(message.msg)
                    .padding()
                    .background(Color(.purple))
                    .clipShape(msgTail(userMsg: message.user == storageManager.currentUser?.id))
                    .foregroundColor(.white)
                Spacer()
            }
            
        }.padding(message.user == storageManager.currentUser?.id ? .leading : .trailing, 55)
        .padding(.vertical,10)
    }
}

struct msgTail : Shape {
    
    var userMsg : Bool
    
    func path(in rect: CGRect) -> Path {
        
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: [.topLeft,.topRight, userMsg ? .bottomLeft : .bottomRight], cornerRadii: CGSize(width: 25, height: 25))
        return Path(path.cgPath)
    }
}


//struct chatCell : View {
//
//    var data : msgdataType
//
//    var body : some View{
//
//        HStack{
//
//            if data.myMsg{
//
//                Spacer()
//
//                Text(data.msg)
//                    .padding()
//                    .background(Color("bg"))
//                    .clipShape(msgTail(mymsg: data.myMsg))
//                    .foregroundColor(.white)
//            }
//            else{
//
//                Text(data.msg)
//                    .padding()
//                    .background(Color("txtbox"))
//                    .clipShape(msgTail(mymsg: data.myMsg))
//
//                Spacer()
//            }
//
//        }.padding(data.myMsg ? .leading : .trailing, 55)
//        .padding(.vertical,10)
//    }
//}
