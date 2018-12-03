//
//  BaseRouter.swift
//  
//
//  Created by Alexey Popkov on 11/29/16.
//  Copyright © 2016 Alexey Popkov. All rights reserved.
//

import UIKit

class BaseRouter //: DismissRoutingProtocol
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

//extension BaseRouter
//{
//    func onDismiss(_ vc: UIViewController, animated: Bool, completion: VoidCompletion?) -> VoidCompletion {
//        return onDismiss(vc, nc: nil, animated: animated, completion: completion)
//    }
//
//    func onDismiss(_ vc: UIViewController, nc: UINavigationController?, animated: Bool, completion: VoidCompletion?) -> VoidCompletion {
//        weak var weakVC = vc
//        if let nc = nc {
//            return {
//                guard let strongVC = weakVC else { return }
//                self.dismissViewController(strongVC, nc: nc, animated: animated, completion: completion)
//            }
//        } else {
//            return {
//                guard let strongVC = weakVC else { return }
//                self.dismissViewController(viewController: strongVC, animated: animated, completion: completion)
//            }
//        }
//    }
//
//    func onDismiss(_ vc: UIViewController) -> VoidCompletion {
//        return onDismiss(vc, animated: true, completion: nil)
//    }
//
//    func onDismiss(_ vc: UIViewController, nc: UINavigationController) -> VoidCompletion {
//        return onDismiss(vc, nc: nc, animated: true, completion: nil)
//    }
//}

//MARK: Present

//extension BaseRouter
//{
//    func pushViewController(_ vc: UIViewController?, nc: UINavigationController?, animated: Bool, completion: VoidCompletion? = nil)
//    {
//        if let nc = nc, let vc = vc {
//            DispatchQueue.main.async {
//                nc.pushViewController(vc, animated: animated)
//                completion?()
//            }
//        }
//    }
//
//    func pushViewController(viewController: UIViewController?, animated: Bool, completion: VoidCompletion? = nil) {
//        pushViewController(viewController, nc: self.navigationController, animated: animated, completion: completion)
//    }
//
//    func presentViewController(_ vc: UIViewController?, nc: UINavigationController?, animated:Bool)
//    {
//        guard let vc = vc else { return }
//        DispatchQueue.main.async {
//            nc?.present(vc, animated: true, completion: nil)
//        }
//    }
//
//    func presentViewController(viewController: UIViewController?, animated: Bool) {
//        presentViewController(viewController, nc: self.navigationController, animated: animated)
//    }
//}

//MARK: Dismiss

//extension BaseRouter
//{
//    func dismissViewController(viewController: UIViewController?, animated: Bool = true,  completion: VoidCompletion? = nil) {
//        dismissViewController(viewController, nc: self.navigationController, animated: animated, completion: completion)
//    }
//
//    func dismissViewController(_ vc: UIViewController?, nc: UINavigationController?, animated: Bool = true, completion: VoidCompletion? = nil)
//    {
//        guard let vc = vc, let nc = nc else {
//            completion?()
//            return
//        }
//
//        let insertedInNavigationStack = nc.viewControllers.contains(vc)
//
//        guard insertedInNavigationStack == true else {
//            vc.dismiss(animated: animated, completion: completion)
//            return
//        }
//
//        let isActiveInStack = (nc.viewControllers.last === vc)
//
//        guard isActiveInStack == true else {
//            completion?()
//            DLog("Dismiss Routing Error")
//            return
//        }
//
//        nc.popViewController(animated: animated)
//
//        completion?()
//    }
//}
