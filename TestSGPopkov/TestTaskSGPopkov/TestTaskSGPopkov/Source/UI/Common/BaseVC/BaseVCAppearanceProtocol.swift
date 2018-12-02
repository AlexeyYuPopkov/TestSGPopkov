//
//  BaseVCAppearanceProtocol.swift
//  
//
//  Created by Alexey Popkov on 11/29/16.
//  Copyright © 2016 Alexey Popkov. All rights reserved.
//

import UIKit

enum NavigationBarAppearanceStyle
{
    case visible
    case hidden
    case inherited
}

protocol BaseVCAppearanceProtocol: NavigationBarAppearanceProtocol {
}

protocol NavigationBarAppearanceProtocol {
    var navigationBarStyle: NavigationBarStyle { get }
    func preferredNavigationBarAppearanceStyle() -> NavigationBarAppearanceStyle
//    func preferredNavigationBarAppearance()
}



