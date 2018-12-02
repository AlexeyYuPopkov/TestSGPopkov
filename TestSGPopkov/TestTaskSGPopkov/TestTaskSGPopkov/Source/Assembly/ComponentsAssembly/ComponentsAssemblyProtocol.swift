//
//  ComponentsAssemblyProtocol.swift
//  
//
//  Created by Alexey Popkov on 11/29/16.
//  Copyright © 2016 Alexey Popkov. All rights reserved.
//

protocol ComponentsAssemblyProtocol:
    ComponentsAssemblyManagersProtocol,
    ComponentsUsersViewControllersModels
{
}

protocol ComponentsAssemblyManagersProtocol {
    var networkClient: NetworkClientProtocol { get }
}

protocol ComponentsUsersViewControllersModels
{
//    var usersListVCVM: UsersListVCVM { get }
//    var selectedUsersListVCVM: SelectedUsersListVCVM { get }
//    func selectUserVCVM(selectedUsersListVCVM: SelectedUsersListVCVM, sersListVCVM: UsersListVCVM)
}

