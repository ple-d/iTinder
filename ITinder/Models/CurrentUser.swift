//
//  CurrentUser.swift
//  ITinder
//
//  Created by XO on 06.09.2021.
//

import Foundation
import SwiftUI

struct CurrentUser: Identifiable, Encodable {
    var id : String
    var name : String
    let email: String
    var location: String
    var imagePaths: [String]
    var likes: [String]
    var dislikes: [String]
    var matches: [String]
    var chats: [String]
    var biography: String
    
    var dictionary: [String: Any] {
        return ["name": name,
                "imagePaths": imagePaths,
                "location": location,
        ]
    }
}
