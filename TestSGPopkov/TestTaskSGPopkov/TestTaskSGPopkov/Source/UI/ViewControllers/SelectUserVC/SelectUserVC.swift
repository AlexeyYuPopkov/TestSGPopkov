//
//  SelectUserVC.swift
//  TestTaskSGPopkov
//
//  Created by Alexey Popkov on 12/1/18.
//  Copyright © 2018 Alexey Popkov. All rights reserved.
//

import UIKit

class SelectUserVC: BaseVC, ShowAlertHelperProtocol
{
    @IBOutlet weak var topContainerView: UIView!
    @IBOutlet weak var bottomContainerView: UIView!
    
    private let components = ComponentsAssembly.shared
    private lazy var navigationAssembly: NavigationAssemblyProtocol = NavigationAssembly(componentsAssembly: components)
    private lazy var selectedUsersListVC = navigationAssembly.assemblySelectedUsersListVC(vm: vm)
    private lazy var usersListVC = navigationAssembly.assemblyUsersListVC(vm: vm)
    private lazy var vm = SelectUserVCVM(networkClient: components.networkClient)
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        setupChildsViewControllers()
    }
    
    private func setupChildsViewControllers()
    {
        addChild(selectedUsersListVC)
        topContainerView.addSubview(selectedUsersListVC.view)
        addAnchors(to: selectedUsersListVC.view, withSuperview: topContainerView)
        selectedUsersListVC.didMove(toParent: self)
        
        addChild(usersListVC)
        bottomContainerView.addSubview(usersListVC.view)
        addAnchors(to: usersListVC.view, withSuperview: bottomContainerView)
        usersListVC.didMove(toParent: self)

    }
}

// MARK: Private

extension SelectUserVC
{
    private func addAnchors(to view: UIView, withSuperview superview: UIView)
    {
        view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            view.leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: 0),
            view.trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: 0),
            view.topAnchor.constraint(equalTo: superview.topAnchor, constant: 0),
            view.bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: 0)
            ])
    }
}
