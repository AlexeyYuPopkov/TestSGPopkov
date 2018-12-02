//
//  NavigationAssembly+Enums.swift
//  TestTasks
//
//  Created by Alexey Popkov on 9/19/18.
//  Copyright © 2018 PopkovTeam. All rights reserved.
//

import Foundation

extension NavigationAssembly
{
    enum StoryboardName: String {
        case main = "Main"
        
        var stringValue: String {
            return rawValue
        }
    }
}
