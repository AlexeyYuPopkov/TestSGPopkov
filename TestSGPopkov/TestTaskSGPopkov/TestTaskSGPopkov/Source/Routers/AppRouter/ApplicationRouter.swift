//
//  ApplicationRouter.swift
//
//
//  Created by Alexey Popkov on 11/29/16.
//  Copyright © 2016 Alexey Popkov. All rights reserved.
//

import UIKit
//import LGSideMenuController

fileprivate  let NavigationStackSwitchingTransistionDuration = 0.3

enum NavigationStack: Int
{
//    case auth
    case userList
}

final class ApplicationRouter: ApplicationRouterProtocol
{
    var navigationController: UINavigationController? {
        return (initialNC as? UINavigationController)
    }
    
    func setNavigationController(_ nc: UINavigationController?) {
        initialNC = nc
    }

    var navigationAssembly: NavigationAssemblyProtocol
    
    let instancesManager = RegisteredInstancesManager()

    var currentNavigationStack = NavigationStack.userList
    
    weak var initialWindow: UIWindow?
    private weak var initialNC: UIViewController?
    
    private var initialNavigationStack: NavigationStack {
        return currentNavigationStack
    }
    
    init(navigationAssembly: NavigationAssemblyProtocol)
    {
        self.navigationAssembly = navigationAssembly
        currentNavigationStack = initialNavigationStack
    }
    
    func initialVC() -> UIViewController
    {
        if initialNC == nil
        {
            switch self.currentNavigationStack
            {
            case .userList:
                initialNC = initialViewControllerForUserListStack
            }
        }
        
        return initialNC!
    }
    
    private var initialViewControllerForUserListStack: UIViewController {
        return self.usersRouter.initialVC()
    }
}

extension ApplicationRouter
{
    func showTabbarStory(completion: (() -> Void)?) {
        switchNavigationToStack(aStack: .userList)
        completion?()
    }
}

// MARK: Switch Navigation Stack

extension ApplicationRouter
{
    private func switchNavigationToStack(aStack: NavigationStack)
    {
//        var theStack = aStack
        
//        if appAssembly.componentsAssembly.authUserProvider.isUserAutorized == false {
//            theStack = .AuthStack
//        }
        
        if aStack == self.currentNavigationStack {
            return
        }
        
        switch aStack
        {
        case .userList:
            initialNC = self.initialViewControllerForUserListStack
        }
        
        transitionProcess(vc: initialNC!, completion: { [weak self] () -> Void in
            guard let `self` = self else { return }
            self.currentNavigationStack = aStack
        })
    }

    private func transitionProcess(vc: UIViewController, completion: VoidCompletion?)
    {
        let options: UIView.AnimationOptions = [.transitionCrossDissolve, .allowAnimatedContent, .layoutSubviews]
        
        guard let window = self.initialWindow else {
            completion?()
            return
        }
        
        UIView.transition(with: window,
                          duration: NavigationStackSwitchingTransistionDuration,
                          options: options,
                          animations:
            {
                window.rootViewController = vc
            },
                          completion:
            { (result) -> Void in
                completion?()
        })
    }
}
