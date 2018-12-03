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


