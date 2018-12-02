//
//  LayoutHelperProtocol.swift
//  TestTaskSGPopkov
//
//  Created by Alexey Popkov on 12/2/18.
//  Copyright © 2018 Alexey Popkov. All rights reserved.
//

import UIKit

protocol LayoutHelperProtocol {
}

extension LayoutHelperProtocol
{
    func addAnchors(to view: UIView, withSuperview superview: UIView)
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
