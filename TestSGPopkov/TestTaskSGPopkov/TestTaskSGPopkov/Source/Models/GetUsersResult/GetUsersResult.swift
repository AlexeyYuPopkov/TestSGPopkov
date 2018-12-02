//
//  GetUsersResult.swift
//  TestTaskSGPopkov
//
//  Created by Alexey Popkov on 12/1/18.
//  Copyright © 2018 Alexey Popkov. All rights reserved.
//

import Foundation

class GetUsersResult: Codable
{
    enum CodingKeys: String, CodingKey {
        case id
        case nodeId = "node_id"
        case login
        case avatarUrlString = "avatar_url"

        var value: String {
            return rawValue
        }
    }
    
    let id: Int
    let nodeId: String
    let login: String
    let avatarUrlString: String?
    
    init(id: Int,
         nodeId: String,
         login: String,
         avatarUrlString: String?)
    {
        self.id = id
        self.nodeId = nodeId
        self.login = login
        self.avatarUrlString = avatarUrlString
    }
    
}
