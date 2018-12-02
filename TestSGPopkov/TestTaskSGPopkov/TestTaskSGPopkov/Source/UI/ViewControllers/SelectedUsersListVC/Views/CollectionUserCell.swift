//
//  CollectionUserCell.swift
//  TestTaskSGPopkov
//
//  Created by Alexey Popkov on 12/2/18.
//  Copyright © 2018 Alexey Popkov. All rights reserved.
//

import UIKit

class CollectionUserCell: UICollectionViewCell
{
    @IBOutlet weak var avatarImageView: KF_ImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var deleteButton: UIButton!
    
    var handleTap: ((CollectionUserCell) -> Void)?

    
    var vm: UserVM? {
        didSet {
            titleLabel.text = vm?.login
            
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
    
    
    @IBAction func didCheckmarckStataChanged(_ sender: UIButton) {
        handleTap?(self)
    }
}
