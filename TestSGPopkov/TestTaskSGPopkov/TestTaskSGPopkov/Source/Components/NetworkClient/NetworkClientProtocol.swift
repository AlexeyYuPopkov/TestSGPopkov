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
}

protocol NetworkClientUsersProtocol {
    func getUsers(lastUserId: Int?, limit: Int) -> Observable<[GetUsersResult]>
}
