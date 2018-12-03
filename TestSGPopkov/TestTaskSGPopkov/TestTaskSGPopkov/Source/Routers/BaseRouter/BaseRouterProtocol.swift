//
//  BaseRouterProtocol.swift
//  
//
//  Created by Alexey Popkov on 11/29/16.
//  Copyright © 2016 Alexey Popkov. All rights reserved.
//

import UIKit

protocol BaseRouterProtocol
{
    func initialVC() -> UIViewController
    var navigationController: UINavigationController? { get }
    func setNavigationController(_ nc: UINavigationController?)
}

//protocol DismissRoutingProtocol
//{
//    func dismissViewController(viewController: UIViewController?, animated:Bool,  completion: (() -> Void)?)
//    func onDismiss(_ vc: UIViewController) -> VoidCompletion
//    func onDismiss(_ vc: UIViewController, animated: Bool, completion: VoidCompletion?) -> VoidCompletion
//}

