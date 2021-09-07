//
//  Message.swift
//  ITinder
//
//  Created by XO on 06.09.2021.
//

import Foundation
//import FirebaseFirestoreSwift
    // idk what's wrong
struct Message: Identifiable, Codable, Hashable {
    var id: String?
    var msg: String
    var user: String
    var timeStamp: Date
    
    enum CodingKeys: String, CodingKey {
        case id
        case msg
        case user
        case timeStamp
    }
}
