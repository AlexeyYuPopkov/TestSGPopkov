//
//  ApplicationRouterProtocol.swift
//  
//
//  Created by Alexey Popkov on 11/29/16.
//  Copyright © 2016 Alexey Popkov. All rights reserved.
//

import UIKit

protocol ApplicationRouterProtocol: BaseRouterProtocol, ApplicationRouterRoutersProtocol
{
    func initialVC() -> UIViewController
    
    var initialWindow: UIWindow? { get set }
    var currentNavigationStack: NavigationStack { get }
    var navigationController: UINavigationController? { get }

    func showTabbarStory(completion: (() -> Void)?)
}

protocol ApplicationRouterRoutersProtocol {
    var usersRouter: UsersRouterProtocol { get }
}

