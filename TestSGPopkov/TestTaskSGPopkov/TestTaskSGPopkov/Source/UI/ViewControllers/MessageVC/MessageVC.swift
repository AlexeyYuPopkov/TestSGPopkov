//
//  MessageVC.swift
//  TestTaskSGPopkov
//
//  Created by Alexey Popkov on 12/3/18.
//  Copyright © 2018 Alexey Popkov. All rights reserved.
//

import UIKit
import RxSwift
import RxKeyboard

protocol MessageVCDelegate: class {
    func didSendButtonTappedWithMessageVC(_ vc: MessageVC)
}

final class MessageVC: BaseTVC
{
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var messageTextView: UITextView!
    @IBOutlet weak var sendButton: UIButton!
    
    private let disposeBag = DisposeBag()
    
    weak var delegate: MessageVCDelegate?
    
    var vm: MessageVCVMProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    private func configure()
    {
        titleLabel.text = "Message:"
        messageTextView.text = ""
        sendButton.setTitle("Send", for: .normal)

        RxKeyboard.instance.willShowVisibleHeight
            .drive(onNext: { [weak self] (height) in
                self?.tableView.contentOffset.y += height
            })
        .disposed(by: disposeBag)
        
        vm.selectedUsersSubj
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] sections in
                guard let `self` = self else { return }
                self.sendButton.isEnabled = sections.count > 0 && sections[0].items.count > 0
            }).disposed(by: disposeBag)
    }
}

extension MessageVC
{
    @IBAction func sendButtonAction(_ sender: UIButton) {
        self.messageTextView.resignFirstResponder()
        self.vm.didSendButtonTapped()
        self.delegate?.didSendButtonTappedWithMessageVC(self)
    }
}

extension MessageVC
{
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }
}
