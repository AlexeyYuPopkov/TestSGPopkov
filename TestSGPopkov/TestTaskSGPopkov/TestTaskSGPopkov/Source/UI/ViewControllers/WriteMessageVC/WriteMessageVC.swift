//
//  SelectUserVC.swift
//  TestTaskSGPopkov
//
//  Created by Alexey Popkov on 12/1/18.
//  Copyright © 2018 Alexey Popkov. All rights reserved.
//

import UIKit
import RxSwift

class WriteMessageVC: BaseVC,
    ShowAlertHelperProtocol,
    LayoutHelperProtocol,
    CommonNavBarVCHelperProtocol
{
    enum Route {
        case dismiss(WriteMessageVC)
    }
    
    @IBOutlet weak var topContainerView: UIView!
    @IBOutlet weak var bottomContainerView: UIView!
    
    var vm: SelectUserVCVM!
    var selectedUsersListVC: SelectedUsersListVC!
    var messageVC: MessageVC!
    
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
        title = "Compose Message"
    }
    
    private func setupChildsViewControllers()
    {
        selectedUsersListVC.disposeBag = disposeBag
        addChild(selectedUsersListVC)
        topContainerView.addSubview(selectedUsersListVC.view)
        addAnchors(to: selectedUsersListVC.view, withSuperview: topContainerView)
        selectedUsersListVC.didMove(toParent: self)

        addChild(messageVC)
        messageVC.delegate = self
        bottomContainerView.addSubview(messageVC.view)
        addAnchors(to: messageVC.view, withSuperview: bottomContainerView)
        messageVC.didMove(toParent: self)
    }
}

// MARK: MessageVCDelegate

extension WriteMessageVC: MessageVCDelegate
{
    func didSendButtonTappedWithMessageVC(_ vc: MessageVC) {
        onRoute?(Route.dismiss(self))
    }
}

