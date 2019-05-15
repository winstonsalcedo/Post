//
//  Post.swift
//  Post
//
//  Created by winston salcedo on 5/13/19.
//  Copyright © 2019 Evolve Technologies. All rights reserved.
//

import Foundation

struct Post: Codable {
    
    let userName: String
    let text: String
    let timestamp: Date
    
    init(userName: String, text: String, timestamp: Date = Date()){
        self.userName = userName
        self.text = text
        self.timestamp = timestamp
    }
}
