//
//  GradientProfilePicture-SwiftUI.swift
//  ITinder
//
//  Created by XO on 06.09.2021.
//

import SwiftUI
import SDWebImageSwiftUI

struct GradientProfilePicture: View {
    @EnvironmentObject var storageManager: StorageManager
    let id: String
    @State var picUrl: URL?
    var gradient1: [Color] = [
        Color.init(red: 101/255, green: 134/255, blue: 1),
        Color.init(red: 1, green: 64/255, blue: 80/255),
        Color.init(red: 109/255, green: 1, blue: 185/255),
        Color.init(red: 39/255, green: 232/255, blue: 1)
    ]
    
    @State private var angle: Double = 0
    
    var body: some View {
        ZStack {
            AngularGradient(gradient: Gradient(colors: gradient1), center: .center, angle: .degrees(angle))
                .mask(
                    Circle()
                        .frame(width: 70, height: 70, alignment: .center)
                        .blur(radius: 8.0)
                )
                .blur(radius: 8.0)
                .onAppear {
                    withAnimation(.linear(duration: 7)) {
                        self.angle += 350
                    }
                }
            WebImage(url: picUrl)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .mask(
                    Circle()
                )
        }.onAppear {
            storageManager.fetchUserPictures(id: id) { data in
                DispatchQueue.main.async {
                    picUrl = data
                }
            }
        }
        
    }
}
