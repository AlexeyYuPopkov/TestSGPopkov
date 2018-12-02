//
//  UsersListCellTableViewCell.swift
//  TestTaskSGPopkov
//
//  Created by Alexey Popkov on 12/1/18.
//  Copyright © 2018 Alexey Popkov. All rights reserved.
//

import UIKit
import RxSwift

class UsersListCell: UITableViewCell
{
    @IBOutlet weak var avatarImageView: KF_ImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var checkmarkButton: UIButton!
    
    var handleTap: ((UsersListCell) -> Void)?
    var disposeBag: DisposeBag?
    
    var vm: UserVM? {
        didSet {
            titleLabel.text = vm?.login
            subtitleLabel.text = vm?.nodeId
            
            disposeBag = DisposeBag()
            
            vm?.isSelected.asDriver(onErrorJustReturn: false)
                .drive(onNext: { [weak self] newValue in
                    self?.checkmarkButton.isSelected = newValue
                }).disposed(by: disposeBag!)
            
            guard let avatarUrlString = vm?.avatarUrlString,
                let avatarUrl = URL(string: avatarUrlString) else {
                    avatarImageView.image = UIImage(named: "AvatarPlaceholder")
                    return
            }
            
            let size = avatarImageView.frame.size
            avatarImageView.vm = KF_ImageView.VM(url: avatarUrl,
                                                 placeholder: UIImage(named: "AvatarPlaceholder"),
                                                 cornerRadius: size.width / 2.0,
                                                 targetSize: size,
                                                 completion: nil)
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = nil
    }
    
    @IBAction func didCheckmarckStataChanged(_ sender: UIButton) {
        handleTap?(self)
    }
}
