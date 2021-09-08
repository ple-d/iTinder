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
    @Binding var search: String
    
    private func textFieldChanged(_ text: String) { storageManager.findChats(search: search) }
    
    var body : some View{
        
        let binding = Binding<String>(
            get: { self.search },
            set: { self.search = $0; self.textFieldChanged($0) }
        )
        
        VStack(spacing: 22){
            
            HStack{
                
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
                
                TextField("Поиск", text: binding).autocapitalization(.none)
                
            }.padding()
            .background(Color.white)
            .cornerRadius(8)
            .padding(.bottom, 10)
            
        }.padding()
        .padding(.top, UIApplication.shared.windows.first?.safeAreaInsets.top)
        .background(LinearGradient(gradient: Gradient(colors: [Color.pink, Color.blue]), startPoint: .top, endPoint: .bottom))
        .navigationBarHidden(true)
        .clipShape(shape())
        .animation(.default)
        .edgesIgnoringSafeArea(.top)
        
    }
}

struct MatchedView_Previews: PreviewProvider {
    static var previews: some View {
        MatchedView(search: .constant("")).environmentObject(StorageManager())
    }
}

struct shape : Shape {
    
    func path(in rect: CGRect) -> Path {
        
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: [.bottomLeft,.bottomRight], cornerRadii: CGSize(width: 30, height: 30))
        
        return Path(path.cgPath)
    }
}
