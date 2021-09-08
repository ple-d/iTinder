//
//  ChatRow.swift
//  ITinder
//
//  Created by XO on 06.09.2021.
//

import SwiftUI
import SDWebImageSwiftUI

struct ChatRow: View {
    @EnvironmentObject var storageManager: StorageManager
    let user: OtherUser
    @State var picture: URL?
    func formatDate(date: Date?) -> String {
        guard let date = date else { return "" }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yy"
        return dateFormatter.string(from: date)
    }
    
    var body: some View {
        HStack(spacing: 15){
            
            WebImage(url: picture ).resizable().aspectRatio(contentMode: .fill).frame(width: 50, height: 50).clipShape(Circle())
            
            VStack(alignment:.leading,spacing: 5){
                
                Text(user.name).bold()
                Text(storageManager.messages[user.id]?.last?.msg ?? "").lineLimit(2).foregroundColor(.gray)
            }
            
            Spacer()
            
            VStack(spacing: 10){
                Text(formatDate(date: storageManager.messages[user.id]?.last?.timeStamp))
                if let countMsgs = storageManager.msgToRead[user.id], countMsgs > 0 {
                    Text("\(countMsgs)").padding(8).background(Color(.blue)).foregroundColor(.white).clipShape(Circle())
                }  else {
                    Spacer()
                }
            }
            
        }
        .onAppear {
            storageManager.fetchUserPictures(id: user.id) { data in
                self.picture = data
            }
        }
        .padding(9)
    }
}
