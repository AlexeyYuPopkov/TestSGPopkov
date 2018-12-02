//
//  StandartNavigationBarViewControllerHelperProtocol.swift
//  TestTasks
//
//  Created by Alexey Popkov on 9/20/18.
//  Copyright © 2018 PopkovTeam. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

protocol CommonNavBarVCHelperProtocol: class {
    var handleLeftNavigationBarButtonTap: BarButtonItemCompletion? { get set }
    var handleRightNavigationBarButtonTap: BarButtonItemCompletion? { get set }
}

fileprivate extension UIViewController
{
    @objc func leftButtonAction(_ button: UIBarButtonItem) {
        guard let theSelf = self as? CommonNavBarVCHelperProtocol else { return }
        theSelf.handleLeftNavigationBarButtonTap?(button)
    }
    
    @objc func rightButtonAction(_ button: UIBarButtonItem) {
        guard let theSelf = self as? CommonNavBarVCHelperProtocol else { return }
        theSelf.handleRightNavigationBarButtonTap?(button)
    }
}

extension CommonNavBarVCHelperProtocol where Self: UIViewController & BaseVCAppearanceProtocol
{
    func configureLeftNavigationBarButton(image: UIImage?, isEnabled: Bool = true, action: BarButtonItemCompletion? = nil)
    {
        let buttonItem = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(leftButtonAction(_:)))
        self.navigationItem.setLeftBarButton(buttonItem, animated: false)
        handleLeftNavigationBarButtonTap = action
        self.navigationItem.leftBarButtonItem?.isEnabled = isEnabled
    }
    
    func configureLeftNavigationBarButton(title: String, isEnabled: Bool = true, action: BarButtonItemCompletion? = nil)
    {
        let buttonItem = UIBarButtonItem(title: title, style: .plain, target: self, action: #selector(leftButtonAction(_:)))
        buttonItem.tintColor = barButtonsTintColor
        self.navigationItem.setLeftBarButton(buttonItem, animated: false)
        handleLeftNavigationBarButtonTap = action
        self.navigationItem.leftBarButtonItem?.isEnabled = isEnabled
    }
    
    func configureRightNavigationBarButton(image: UIImage?, isEnabled: Bool = true, action: BarButtonItemCompletion? = nil)
    {
        let buttonItem = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(rightButtonAction(_:)))
        buttonItem.tintColor = barButtonsTintColor
        self.navigationItem.setRightBarButton(buttonItem, animated: false)
        handleRightNavigationBarButtonTap = action
        self.navigationItem.rightBarButtonItem?.isEnabled = isEnabled
    }
    
    func configureRightNavigationBarButton(title: String, isEnabled: Bool = true, action: BarButtonItemCompletion? = nil)
    {
        let buttonItem = UIBarButtonItem(title: title, style: .plain, target: self, action: #selector(rightButtonAction(_:)))
        buttonItem.tintColor = barButtonsTintColor
        self.navigationItem.setRightBarButton(buttonItem, animated: false)
        handleRightNavigationBarButtonTap = action
        self.navigationItem.rightBarButtonItem?.isEnabled = isEnabled
    }
    
    var isNavigationBarLeftButtonEnabled: Bool? {
        get {
            return self.navigationItem.leftBarButtonItem?.isEnabled
        }
        set {
            if let theNewValue = newValue {
                self.navigationItem.leftBarButtonItem?.isEnabled = theNewValue
            }
        }
    }
    
    var isNavigationBarRightButtonEnabled: Bool? {
        get { return self.navigationItem.rightBarButtonItem?.isEnabled }
        set {
            if let theNewValue = newValue {
                self.navigationItem.rightBarButtonItem?.isEnabled = theNewValue
            }
        }
    }
}
