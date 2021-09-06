//
//  MessagesView.swift
//  ITinder
//
//  Created by XO on 06.09.2021.
//

import SwiftUI

struct MessagesView: View {
    @EnvironmentObject var storageManager: StorageManager
    
    @State var expand = false
    
    var body: some View {
        VStack(spacing: 0){
            MatchView().zIndex(25)
            ChatsView().offset(y: -25)
        }.navigationBarTitle("Чаты", displayMode: .inline)
    }
}

struct MessagesView_Previews: PreviewProvider {
    static var previews: some View {
        MessagesView()
    }
}
