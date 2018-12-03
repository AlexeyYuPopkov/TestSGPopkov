//
//  NavigationAssemblyProtocol.swift
//  
//
//  Created by Alexey Popkov on 11/29/16.
//  Copyright © 2016 Alexey Popkov. All rights reserved.
//

import UIKit

protocol NavigationAssemblyProtocol
{
    func assemblyNavigationControllerWithItem(_ viewController: UIViewController) -> UINavigationController
    
    func assemblySelectUserVC() -> SelectUserVC
    func assemblyWriteMessageVC(vm: SelectedUsersListVCVMProtocol) -> WriteMessageVC
}





