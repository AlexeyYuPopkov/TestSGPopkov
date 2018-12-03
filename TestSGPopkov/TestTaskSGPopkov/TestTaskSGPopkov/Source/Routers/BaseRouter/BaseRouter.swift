//
//  BaseRouter.swift
//  
//
//  Created by Alexey Popkov on 11/29/16.
//  Copyright © 2016 Alexey Popkov. All rights reserved.
//

import UIKit

class BaseRouter
{
    var navigationAssembly: NavigationAssemblyProtocol
    
    var appRouter: ApplicationRouterProtocol!
    
    weak var navigationController: UINavigationController?

    init(navigationAssembly: NavigationAssemblyProtocol,
         applicationRouter: ApplicationRouterProtocol)
    {
        self.navigationAssembly = navigationAssembly
        self.appRouter = applicationRouter
    }
    
    deinit {
        DLog("\(StringHelper.classNameForObject(self)) -- deinit")
    }
    
    func setApplicationRouter(_ appRouter: ApplicationRouter) {
        self.appRouter = appRouter
    }
    
    func setNavigationController(_ nc: UINavigationController?) {
        self.navigationController = nc
    }
}

