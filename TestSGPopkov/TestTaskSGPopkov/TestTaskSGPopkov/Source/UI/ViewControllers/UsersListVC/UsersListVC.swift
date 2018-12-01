//
//  ViewController.swift
//  TestTaskSGPopkov
//
//  Created by Alexey Popkov on 12/1/18.
//  Copyright © 2018 Alexey Popkov. All rights reserved.
//

import UIKit

class UsersListVC: UITableViewController
{
    lazy var vm = UsersListVCVM(networkClient: ComponentsAssembly.shared.networkClient)
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

    }


}

