//
//  StorageManager.swift
//  ITinder
//
//  Created by XO on 06.09.2021.
//

import SwiftUI
import Firebase

class StorageManager : ObservableObject {
    
    @Published var currentUser: CurrentUser?
    @Published var users = [OtherUser]()
    @Published var matches = [OtherUser]()
    @Published var chats = [OtherUser]()
    @Published var messages = [String:[Message]]()
    
    private let db = Firestore.firestore()
    private let storage = Storage.storage()
    private var curMatches = [String]()
    private var curChats = Set<String>()
    
    func checkChats(id: String, chats: Set<String>, matches: [OtherUser]) {
        if self.curChats != chats {
            
            let added = chats.subtracting(self.curChats)
            self.curChats = chats
            
            for chatId in added {
                if let chat = matches.first( where: {$0.id == chatId }) {
                    
                    self.chats.insert(chat, at: 0)}
                
                self.setUserChatListener(userId: id, chatId: chatId)
            }
        }
    }
    
    func setUserListener(id: String) {
        db.collection("users").document(id)
            .addSnapshotListener { documentSnapshot, error in
                guard let document = documentSnapshot, document.exists else {
                    print("Error fetching document: \(error?.localizedDescription ?? "")")
                    return
                }
                guard let data = document.data() else {
                    print("Document data was empty.")
                    return
                }
                
                let matches = data["matches"] as? [String] ?? []
                let chats = Set(data["chats"] as? [String] ?? [])
                let imagePaths = data["imagePaths"] as? [String] ?? []
                
                self.currentUser = CurrentUser(id: id, name: data["name"] as? String ?? "", email: data["email"] as? String ?? "", location: data["location"] as? String ?? "", imagePaths: imagePaths, likes: data["likes"] as? [String] ?? [], dislikes: data["dislikes"] as? [String] ?? [], matches: matches, chats: Array(chats), biography: data["biography"] as? String ?? "")
                
                if self.curMatches != matches {
                    self.curMatches = matches
                    self.fetchMatches(matches: matches) { data in
                        self.matches = data
                        self.checkChats(id: id, chats: chats, matches: data)
                    }
                } else {
                    if !matches.isEmpty {
                        self.checkChats(id: id, chats: chats, matches: self.matches)
                    }
                }
            }
    }
    
    func setUserChatListener(userId: String, chatId: String) {
        
        db.collection("users").document(userId).collection(chatId).addSnapshotListener { snap, error in
            if error != nil {
                print(error?.localizedDescription ?? "")
                return
            }
            
            guard let data = snap else { return }
            var msgs = self.messages[chatId] ?? []
            data.documentChanges.forEach { doc in
                
                if doc.type == .added {
                    
                    guard let msg = try? doc.document.data(as: Message.self) else { return }
                    msgs.append(msg)
                    DispatchQueue.main.async {
                        self.messages[chatId] = msgs.sorted { $0.timeStamp < $1.timeStamp}
                    }
                }
            }
        }
    }
    
    func sendMessage(chatId: String, message: Message) {
        guard let currentUser = currentUser else { return }
        let _ = try! db.collection("users").document(chatId).collection(currentUser.id).addDocument(from: message) {error in
            if error != nil {
                print(error!.localizedDescription)
                return
            }}
        let _ = try! db.collection("users").document(currentUser.id).collection(chatId).addDocument(from: message) {
            error in
            if error != nil {
                print(error!.localizedDescription)
                return
            }
            
            if !currentUser.chats.contains(chatId){
                var chats = currentUser.chats
                chats.append(chatId)
                self.updateUser(value: ["chats": chats])
            }
        }
    }
    
    
    func fetchMatches(matches: [String], completion: @escaping ([OtherUser]) -> ()) {
        let group = DispatchGroup()
        
        var matchesData = [OtherUser]()
        for id in matches {
            group.enter()
            let docRef = self.db.collection("users").document(id)
            docRef.getDocument { (document, error) in
                defer { group.leave() }
                if let document = document, document.exists {
                    guard let data = document.data() else {
                        print("Document data was empty.")
                        return
                    }
                    matchesData.append(OtherUser(id: id, name: data["name"] as? String ?? ""))
                    
                } else {
                    print("Document does not exist")
                }
            }
            
        }
        group.notify(queue: .main) {
            completion(matchesData)
        }
    }
    
    
    func updateUser(value: [String: Any]) {
        guard let id = currentUser?.id else { return }
        let docRef = db.collection("users").document(id)
        docRef.updateData(value) { error in
            if let error = error {
                print(error.localizedDescription)
            } else {
                print("Document successfully updated")
            }
        }
    }
    
    func fetchUserPictures(id: String, completion: @escaping (URL)->()) {
        let storageRef = storage.reference().child("users/\(id)/images")
        storageRef.listAll { (result, error) in
            
            if let error = error {
                print("Error while listing all files: ", error)
            }
            
            let storageLocation = String(describing: result.items[0])
            let gsReference = Storage.storage().reference(forURL: storageLocation)
            
            // Fetch the download URL
            gsReference.downloadURL { url, error in
                guard error == nil, let url = url else { print("error, \(error?.localizedDescription ?? "")")
                    return }
                completion(url)
            }
            
        }
        
    }
}
