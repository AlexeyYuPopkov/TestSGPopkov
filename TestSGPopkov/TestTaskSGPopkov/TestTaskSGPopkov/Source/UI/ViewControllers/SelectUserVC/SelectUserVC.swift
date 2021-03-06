//
//  SelectUserVC.swift
//  TestTaskSGPopkov
//
//  Created by Alexey Popkov on 12/1/18.
//  Copyright © 2018 Alexey Popkov. All rights reserved.
//

import UIKit
import RxSwift

class SelectUserVC: BaseVC, ShowAlertHelperProtocol, LayoutHelperProtocol, CommonNavBarVCHelperProtocol
{
    enum Route {
        case next(SelectUserVCVM)
    }
    
    @IBOutlet weak var topContainerView: UIView!
    @IBOutlet weak var bottomContainerView: UIView!
    
    var vm: SelectUserVCVM!
    var selectedUsersListVC: SelectedUsersListVC!
    var usersListVC: UsersListVC!
    
    let disposeBag = DisposeBag()
    
    var onRoute: ((Route) -> Void)?
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        setupChildsViewControllers()
        configure()
    }
    
    private func configure()
    {
        title = "Selected Users"
        
        configureRightNavigationBarButton(title: "Next", isEnabled: true) { [weak self] button in
            guard let `self` = self else { return }
            self.onRoute?(Route.next(self.vm))
        }

        vm.selectedUsersSubj
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] sections in
            guard let `self` = self else { return }
            self.isNavigationBarRightButtonEnabled = sections.count > 0 && sections[0].items.count > 0
        }).disposed(by: disposeBag)
    }
    
    private func setupChildsViewControllers()
    {
        selectedUsersListVC.disposeBag = disposeBag
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

