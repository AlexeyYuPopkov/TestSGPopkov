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
    func adjustNavigationBarAppearance()
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
    
    func adjustNavigationBarAppearance() {
        defaultNavigationBarAppearance()
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
    
    func adjustNavigationBarAppearance() {
        defaultNavigationBarAppearance()
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
    
    func adjustNavigationBarAppearance() {
        defaultNavigationBarAppearance()
    }
}

// MARK: AppearanceProtocol

fileprivate extension NavigationBarAppearanceProtocol where Self: UIViewController & BaseVCProtocol
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
        adjustNavigationBarAppearance()
    }
    
    func createFilledImage(rect: CGRect, color: UIColor) -> UIImage
    {
        UIGraphicsBeginImageContext(rect.size)
        defer {
            UIGraphicsEndImageContext()
        }
        
        let context = UIGraphicsGetCurrentContext()
        context!.setFillColor(color.cgColor)
        context!.fill(rect)
        
        return UIGraphicsGetImageFromCurrentImageContext()!
    }
    
    func imageWithColor(color: UIColor) -> UIImage {
        return self.createFilledImage(rect: CGRect(x: 0.0, y: 0.0, width: 1.0, height: 1.0), color: color)
    }
    

    
    func defaultNavigationBarAppearance() {
        guard let bar = self.navigationController?.navigationBar else {
            return
        }
        
        bar.barStyle = .black
        bar.barTintColor = UIColor.white
        bar.tintColor = UIColor.white
        bar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        bar.setBackgroundImage(self.imageWithColor(color: UIColor.black), for: .default)
        bar.shadowImage = self.imageWithColor(color: UIColor.darkGray)
    }
}

