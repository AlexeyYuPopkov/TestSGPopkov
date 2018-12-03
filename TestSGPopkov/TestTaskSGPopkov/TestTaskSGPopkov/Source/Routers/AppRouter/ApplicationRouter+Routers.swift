//
//  ApplicationRouter+Routers.swift
//  TestTasks
//
//  Created by Alexey Popkov on 9/20/18.
//  Copyright © 2018 PopkovTeam. All rights reserved.
//

import Foundation

// MARK: ApplicationRouterRoutersProtocol

extension ApplicationRouter
{
    var usersRouter: UsersRouterProtocol
    {
        let constructor: AnyObjectConstructor = { [unowned self] () -> AnyObject in
            return UsersRouter(navigationAssembly: self.navigationAssembly, applicationRouter: self)
        }
        
        return instancesManager.instanceForClass(UsersRouter.self,
                                                 constructor: constructor) as! UsersRouterProtocol
    }
}
