//
//  ComponentsAssembly.swift
//
//
//  Created by Alexey Popkov on 11/29/16.
//  Copyright © 2016 Alexey Popkov. All rights reserved.
//

import Foundation

final class ComponentsAssembly: ComponentsAssemblyProtocol
{
    static let shared: ComponentsAssemblyProtocol = ComponentsAssembly()
    lazy var instancesManager = RegisteredInstancesManager()

//    lazy var localization: LocalizationProtocol = Localization()
    
    private init() { }
}

// MARK: ComponentsAssemblyManagersProtocol

extension ComponentsAssembly
{
    var networkClient: NetworkClientProtocol {
        let constructor: AnyObjectConstructor = { [unowned self] () -> AnyObject in
            return NetworkClient(mapper: self.networkClientObjectMapper)
        }

        return instancesManager.instanceForClass(NetworkClient.self,
                                                 constructor: constructor) as! NetworkClientProtocol
    }

    var networkClientObjectMapper: NetworkClientObjectMapper {
        let constructor: AnyObjectConstructor = { () -> AnyObject in
            return NetworkClientObjectMapper()
        }

        return instancesManager.instanceForClass(NetworkClientObjectMapper.self,
                                                 constructor: constructor) as! NetworkClientObjectMapper
    }
}

// MARK: ComponentsAssemblyDataSourcesProtocol

extension ComponentsAssembly
{
//    var usersDataSource: UsersDataSourceProtocol {
//        let constructor: AnyObjectConstructor = { [unowned self] () -> AnyObject in
//            return UsersDataSource(network: self.networkClient, dataBase: self.dataBase)
//        }
//
//        return instancesManager.instanceForClass(UsersDataSource.self,
//                                                 constructor: constructor) as! UsersDataSourceProtocol
//    }
//
//    var savedUsersDataSource: SavedUsersDataSourceProtocol {
//        let constructor: AnyObjectConstructor = { [unowned self] () -> AnyObject in
//            return SavedUsersDataSource(dataBase: self.dataBase)
//        }
//
//        return instancesManager.instanceForClass(SavedUsersDataSource.self,
//                                                 constructor: constructor) as! SavedUsersDataSourceProtocol
//    }
}

extension ComponentsAssembly
{
//    func userProfileDataSource(_ user: UpdatedUser) -> UserProfileDataSourceProtocol {
//        return UserProfileDataSource(user: user, dataBase: dataBase)
//    }
}

// MARK: ComponentsAssemblyValidatorsProtocol

extension ComponentsAssembly
{
//    var emailValidator: InputFieldValidatorProtocol {
//        return instancesManager.instanceForClass(EmailValidator.self)
//        { () -> AnyObject in
//            return EmailValidator()
//        } as! InputFieldValidatorProtocol
//    }
//    
//    var userNameValidator: InputFieldValidatorProtocol {
//        return instancesManager.instanceForClass(UserNameValidator.self)
//        { () -> AnyObject in
//            return UserNameValidator()
//            } as! InputFieldValidatorProtocol
//    }
//    
//    var phoneValidator: InputFieldIsValidProtocol {
//        return instancesManager.instanceForClass(PhoneValidator.self)
//        { () -> AnyObject in
//            return PhoneValidator()
//            } as! InputFieldIsValidProtocol
//    }
}


