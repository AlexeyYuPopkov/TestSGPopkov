//
//  UserVM.swift
//  TestTaskSGPopkov
//
//  Created by Alexey Popkov on 12/2/18.
//  Copyright © 2018 Alexey Popkov. All rights reserved.
//

import Foundation
import RxSwift

class UserVM: Hashable
{
    static func == (lhs: UserVM, rhs: UserVM) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
    
    let user: GetUsersResult
    var isSelected: BehaviorSubject<Bool>
    
    var login: String {
        return user.login
    }
    
    var nodeId: String {
        return user.nodeId
    }
    
    var avatarUrlString: String? {
        return user.avatarUrlString
    }
    
    init(user: GetUsersResult, isSelected: Bool = false)
    {
        self.user = user
        self.isSelected = BehaviorSubject(value: isSelected)
    }
    
    var hashValue: Int {
        return user.id ^ user.login.hashValue ^ user.nodeId.hashValue
    }
}
