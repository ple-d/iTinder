//
//  ChatTopView.swift
//  ITinder
//
//  Created by XO on 06.09.2021.
//

import SwiftUI

struct ChatTopView: View {
    @EnvironmentObject var storageManager : StorageManager
    @Environment(\.presentationMode) var presentationMode
    let user: OtherUser
    
    var body : some View{
        
        
        HStack(spacing : 15){

            Button(action: {
                presentationMode.wrappedValue.dismiss()
            }) {

                Image(systemName: "control").font(.title).rotationEffect(.init(degrees: -90))
            }
            
            Spacer()
            
            VStack(spacing: 5){
                
                GradientProfilePicture(id: user.id)
                    .frame(width: 60, height: 60)
                
//                Image(data.selectedData.pic).resizable().frame(width: 45, height: 45).clipShape(Circle())
                
                Text(user.name).fontWeight(.heavy)
                
            }.offset(x: 25)
            
            
            Spacer()
            
            Button(action: {
                
            }) {
                
                Image(systemName: "phone.fill").resizable().frame(width: 20, height: 20)
                
            }.padding(.trailing, 25)
            
            Button(action: {
                
            }) {
                
                Image(systemName: "video.fill").resizable().frame(width: 23, height: 16)
            }
            
        }.navigationBarHidden(true)
        .foregroundColor(.white)
            .padding()
    }
}
