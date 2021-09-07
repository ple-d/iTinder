//
// Created by R S on 06.09.2021.
//

import SwiftUI
import SDWebImageSwiftUI

struct MatchCell: View {
    @EnvironmentObject var storageManager: StorageManager
    @Environment(\.presentationMode) var presentationMode
    let user: OtherUser
    @State var picture: URL?

    var body: some View {
        VStack {
            WebImage(url: picture).resizable().aspectRatio(contentMode: .fill).frame(width: 60, height: 60)
            
        }
        .onAppear {
            storageManager.fetchUserPictures(id: user.id) { data in
                DispatchQueue.main.async {
                    self.picture = data
                }            }
        }
    }
}
