//
//  BaseVC.swift
//
//
//  Created by Alexey Popkov on 11/29/16.
//  Copyright © 2016 Alexey Popkov. All rights reserved.
//

import UIKit

enum NavigationBarStyle {
    case oldStyle
    case newStyle
    case whiteStyle
}


protocol BaseVCProtocol: BaseVCAppearanceProtocol
{
}

typealias BaseViewControllerProtocol = UIViewController & BaseVCProtocol

class BaseVC: UIViewController, BaseVCProtocol
{
    var handleLeftNavigationBarButtonTap: BarButtonItemCompletion?
    var handleRightNavigationBarButtonTap: BarButtonItemCompletion?

    var navigationBarStyle: NavigationBarStyle = .oldStyle
    
    #if DEBUG
    deinit {
        DLog("\(StringHelper.classNameForObject(self)): deinit")
    }
    #endif

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateNavigationBarStyleAnimated(animated: animated)
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    func preferredNavigationBarAppearanceStyle() -> NavigationBarAppearanceStyle {
        return .visible
    }
}

// MARK: BaseTVC

class BaseTVC: UITableViewController, BaseVCProtocol
{
    var handleLeftNavigationBarButtonTap: BarButtonItemCompletion?
    var handleRightNavigationBarButtonTap: BarButtonItemCompletion?


    var navigationBarStyle: NavigationBarStyle = .oldStyle
    
    #if DEBUG
    deinit {
        DLog("\(StringHelper.classNameForObject(self)): deinit")
    }
    #endif
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateNavigationBarStyleAnimated(animated: animated)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    func preferredNavigationBarAppearanceStyle() -> NavigationBarAppearanceStyle {
        return .visible
    }
}

// MARK: BaseTVC

class BaseCollectionVC: UICollectionViewController, BaseVCProtocol
{
    var handleLeftNavigationBarButtonTap: BarButtonItemCompletion?
    var handleRightNavigationBarButtonTap: BarButtonItemCompletion?
    
    var navigationBarStyle: NavigationBarStyle = .oldStyle
    
    #if DEBUG
    deinit {
        DLog("\(StringHelper.classNameForObject(self)): deinit")
    }
    #endif
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateNavigationBarStyleAnimated(animated: animated)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    func preferredNavigationBarAppearanceStyle() -> NavigationBarAppearanceStyle {
        return .visible
    }
}

// MARK: AppearanceProtocol

fileprivate extension NavigationBarAppearanceProtocol where Self: UIViewController
{
    fileprivate func updateNavigationBarStyleAnimated(animated: Bool)
    {
        guard let navigationController = self.navigationController else {
            return
        }
        
        var isHidden = false;
        
        switch self.preferredNavigationBarAppearanceStyle()
        {
        case .inherited:
            return
        case .visible:
            isHidden = false
        case .hidden:
            isHidden = true
        }
        
        navigationController.setNavigationBarHidden(isHidden, animated: animated);
        navigationController.navigationBar.barStyle = .default
//        (self as? BaseVCProtocol)?.preferredNavigationBarAppearance()
    }
}

