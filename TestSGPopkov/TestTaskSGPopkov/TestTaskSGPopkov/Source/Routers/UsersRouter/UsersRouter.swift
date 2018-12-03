//
//  UsersRouter.swift
//  TestTasks
//
//  Created by Alexey Popkov on 9/20/18.
//  Copyright © 2018 PopkovTeam. All rights reserved.
//

import UIKit

final class UsersRouter:
    BaseRouter,
    UsersRouterProtocol
{
    func initialVC() -> UIViewController
    {
        let vc = self.navigationAssembly.assemblySelectUserVC()

        let nc = self.navigationAssembly.assemblyNavigationControllerWithItem(vc)
        
        self.navigationController = nc
        
        vc.onRoute = { route in
            switch route {
            case .next(let vm):
                self.pushWriteMessageVC(vm: vm)
            }
        }
        
        return nc
    }
    
    func pushWriteMessageVC(vm: SelectedUsersListVCVMProtocol) {
        let vc = navigationAssembly.assemblyWriteMessageVC(vm: vm)
        vc.onRoute = { route in
            switch route {
            case .dismiss(_):
                self.navigationController?.popViewController(animated: true)
            }
        }
        navigationController?.pushViewController(vc, animated: true)
    }
}
