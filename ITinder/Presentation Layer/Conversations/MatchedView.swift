//
//  MatchedView.swift
//  ITinder
//
//  Created by XO on 06.09.2021.
//

import SwiftUI
import SDWebImageSwiftUI

struct MatchedView: View {
    @EnvironmentObject var storageManager: StorageManager
    @Environment(\.presentationMode) var presentationMode
    @State var search = ""
    
    var body : some View{
        
        VStack(spacing: 22){
            
            HStack{
                
//                Button(action: {
//                    presentationMode.wrappedValue.dismiss()
//                }) {
//
//                    Image(systemName: "control").font(.title).rotationEffect(.init(degrees: -90))
//                }
                
                Text("Ваши матчи")
                    .fontWeight(.bold)
                    .font(.title)
                
                Spacer()
                
                
            }.foregroundColor(.white)
            
            ScrollView(.horizontal, showsIndicators: false) {
                
                HStack(spacing: 18){
                    
                    ForEach(storageManager.matches){user in
                        
                        NavigationLink(destination: ChatView(user: user).environmentObject(storageManager)) {
                            MatchCell(user: user).clipShape(Circle())
                        }
                        
                    }
                }
            }
            
            HStack(spacing: 15){
                
                Image(systemName: "magnifyingglass")
                .resizable()
                .frame(width: 18, height: 18)
                .foregroundColor(Color.black.opacity(0.3))
                
                TextField("Поиск", text: self.$search)
                
            }.padding()
            .background(Color.white)
            .cornerRadius(8)
            .padding(.bottom, 10)
            
        }.padding()
        .padding(.top, UIApplication.shared.windows.first?.safeAreaInsets.top)
        .background(Color(.systemBlue))
        .navigationBarHidden(true)
        .clipShape(shape())
        .animation(.default)
        .edgesIgnoringSafeArea(.top)
        
    }
}

struct MatchedView_Previews: PreviewProvider {
    static var previews: some View {
        MatchedView().environmentObject(StorageManager())
    }
}

struct shape : Shape {
    
    func path(in rect: CGRect) -> Path {
        
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: [.bottomLeft,.bottomRight], cornerRadii: CGSize(width: 30, height: 30))
        
        return Path(path.cgPath)
    }
}

