//
//  ShowAlertHelperProtocol.swift
//  TestTasks
//
//  Created by Alexey Popkov on 9/21/18.
//  Copyright © 2018 PopkovTeam. All rights reserved.
//

import UIKit

protocol ShowAlertHelperProtocol {
}

extension ShowAlertHelperProtocol where Self: UIViewController & BaseVCProtocol
{
    func showAlert(title: String? = nil,
                   message: String?,
                   autohide: Bool = false,
                   handler: VoidCompletion? = nil)
    {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default)
        { _ in
            handler?()
        })
        
        self.present(alert, animated: true, completion: nil)
    }
}
