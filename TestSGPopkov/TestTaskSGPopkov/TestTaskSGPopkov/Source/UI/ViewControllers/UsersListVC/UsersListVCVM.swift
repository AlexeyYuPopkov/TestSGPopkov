//
//  UsersListVCVM.swift
//  TestTaskSGPopkov
//
//  Created by Alexey Popkov on 12/1/18.
//  Copyright © 2018 Alexey Popkov. All rights reserved.
//

import Foundation

final class UsersListVCVM
{
    let network: NetworkClientUsersProtocol
    
    init(networkClient: NetworkClientUsersProtocol)
    {
        self.network = networkClient
    }
    
    func load() {
        
    }
    
    
}
