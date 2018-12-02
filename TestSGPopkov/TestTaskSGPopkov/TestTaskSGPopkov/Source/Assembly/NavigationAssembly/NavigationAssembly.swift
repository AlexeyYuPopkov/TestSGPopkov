//
//  NavigationAssembly.swift
//  
//
//  Created by Alexey Popkov on 11/29/16.
//  Copyright © 2016 Alexey Popkov. All rights reserved.
//

import UIKit

final class NavigationAssembly: NavigationAssemblyProtocol
{
    var components: ComponentsAssemblyProtocol!
    
    init(componentsAssembly: ComponentsAssemblyProtocol)
    {
        self.components = componentsAssembly
    }
    
    func assemblyNavigationControllerWithItem(_ vc: UIViewController) -> UINavigationController {
        return UINavigationController(rootViewController: vc)
    }
}

// MARK: Common

extension NavigationAssembly
{
    func assemblyUsersListVC(vm: UsersListVCVMProtocol) -> UsersListVC {
        let vc = instantiateVC(Class: UsersListVC.self, Storyboard: storyboardWithName(.main)) as! UsersListVC
        vc.vm = vm
        return vc
    }
    
    func assemblySelectedUsersListVC(vm: SelectedUsersListVCVMProtocol) -> SelectedUsersListVC {
        let vc = instantiateVC(Class: SelectedUsersListVC.self, Storyboard: storyboardWithName(.main)) as! SelectedUsersListVC
        vc.vm = vm
        return vc
    }
}


// MARK: Private

extension NavigationAssembly
{
    internal func instantiateVC(Class aClass : AnyClass,
                                Storyboard storyboard : UIStoryboard) -> AnyObject
    {
        let path = NSStringFromClass(aClass).components(separatedBy: ".");
        let identifier = path.last!
        let vc = storyboard.instantiateViewController(withIdentifier: identifier)
        return vc
    }
    
    internal func storyboardWithName(_ name: StoryboardName) -> UIStoryboard {
        return UIStoryboard(name: name.stringValue, bundle: Bundle(for: type(of: self)))
    }
}

