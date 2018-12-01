//
//  NetworkClientProtocol.swift
//  TestTasks
//
//  Created by Alexey Popkov on 9/20/18.
//  Copyright © 2018 PopkovTeam. All rights reserved.
//

import Foundation
import RxSwift

protocol NetworkClientProtocol: NetworkClientUsersProtocol
{
//    func getUsers(page: Int,
//                  limit: Int,
//                  success: ((_ result: GetUsersResult?) -> Void)?,
//                  failure: ErrorCompletion?)
    
}

protocol NetworkClientUsersProtocol {
    func getUsers(page: Int, limit: Int) -> Observable<GetUsersResult?>
}
