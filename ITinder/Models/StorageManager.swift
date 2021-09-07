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
                        self.messages[chatId] = msgs
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
    
    func fetchUsers(completion: @escaping () -> ()) {
        guard let currentUser = currentUser else { return }
        self.db.collection("users").getDocuments { (snap, error) in
            
            if let error = error {
                
                print(error.localizedDescription)
                return
            }
            
            guard let data = snap else { return }
            
            for i in data.documents {
                if self.users.count == 2 {
                    break
                }
                let id = i.documentID
                
                if currentUser.likes.contains(id) || currentUser.dislikes.contains(id) || id == currentUser.id {
                    continue
                }
                self.users.append(OtherUser(id: id, name: i.get("name") as? String ?? ""))
                completion()
            }
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
    
    func updateUserMatches(id: String) {
        guard let currentUser = currentUser else { return }
        var curUserLiked = Set(currentUser.likes)
        var curUserMatches = Set(currentUser.matches)
        curUserLiked.insert(id)
        let docRef = db.collection("users").document(id)
        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                guard let data = document.data() else {
                    print("Document data was empty.")
                    return
                }
                let otherLiked = data["liked"] as? [String] ?? []
                var otherMatches = Set(data["matches"] as? [String] ?? [])
                if otherLiked.contains(currentUser.id) {
                    curUserMatches.insert(id)
                    otherMatches.insert(currentUser.id)
                    docRef.updateData(["matches": Array(otherMatches)])
                    self.updateUser(value: ["liked": Array(curUserLiked), "matches": Array(curUserMatches)])
                } else {
                    self.updateUser(value: ["liked": Array(curUserLiked)])
                }
            }
        }
    }
    
    func uploadImage(image: UIImage, completion: @escaping (String?) -> ()) {
        // Create a storage reference
        let storageRef = storage.reference().child("images/\(String(describing: currentUser?.id))/image.jpg")
        
        // Resize the image to 200px with a custom extension
        let resizedImage = image.aspectFittedToHeight(200)
        
        // Convert the image into JPEG and compress the quality to reduce its size
        let data = resizedImage.jpegData(compressionQuality: 0.2)
        
        // Change the content type to jpg. If you don't, it'll be saved as application/octet-stream type
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpg"
        
        // Upload the image
        if let data = data {
            storageRef.putData(data, metadata: metadata) { (metadata, error) in
                if let error = error {
                    print("Error while uploading file: ", error)
                }
                storageRef.downloadURL { url, error in
                    completion(url?.absoluteString)
                }
            }
        }
    }
    
    func fetchUserPictures(id: String, completion: @escaping ([URL])->()) {
        let group = DispatchGroup()
        let storageRef = storage.reference().child("users/\(id)/images")
        var data = [URL]()
        // List all items in the images folder
        group.enter()
        storageRef.listAll { (result, error) in
            
            if let error = error {
                print("Error while listing all files: ", error)
            }
           
            for item in result.items {
                //List storage reference
                
                let storageLocation = String(describing: item)
                let gsReference = Storage.storage().reference(forURL: storageLocation)
                
                // Fetch the download URL
                gsReference.downloadURL { url, error in
                    defer { group.leave() }
                    guard error == nil, let url = url else { print("error, \(error?.localizedDescription ?? "")")
                        return }
                    data.append(url)
                }
            }
        }
        group.notify(queue: .main) {
            completion(data)
        }
    }
}
