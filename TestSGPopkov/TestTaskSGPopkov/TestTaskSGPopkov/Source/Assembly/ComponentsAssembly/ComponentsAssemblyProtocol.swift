//
//  ComponentsAssemblyProtocol.swift
//  
//
//  Created by Alexey Popkov on 11/29/16.
//  Copyright © 2016 Alexey Popkov. All rights reserved.
//

protocol ComponentsAssemblyProtocol:
    ComponentsAssemblyManagersProtocol //,
//    ComponentsAssemblyDataSourcesProtocol,
//    ComponentsAssemblyValidatorsProtocol
{
//    var localization: LocalizationProtocol  { get }
}

protocol ComponentsAssemblyManagersProtocol {
    var networkClient: NetworkClientProtocol { get }
}


//protocol ComponentsAssemblyDataSourcesProtocol
//{
//    var savedUsersDataSource: SavedUsersDataSourceProtocol { get }
//    var usersDataSource: UsersDataSourceProtocol { get }
//    func userProfileDataSource(_ user: UpdatedUser) -> UserProfileDataSourceProtocol
//}
//
//protocol ComponentsAssemblyValidatorsProtocol
//{
//    var userNameValidator: InputFieldValidatorProtocol { get }
//    var emailValidator: InputFieldValidatorProtocol  { get }
//    var phoneValidator: InputFieldIsValidProtocol { get }
//}
