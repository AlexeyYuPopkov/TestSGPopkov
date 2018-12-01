//
//  DebugHelper.swift
//  
//
//  Created by Alexey Popkov on 11/29/16.
//  Copyright © 2016 Alexey Popkov. All rights reserved.
//

import Foundation

final class DebugHelper
{
    public static var isDebug: Bool {
        #if DEBUG
            return true
        #else
            return false
        #endif
    }
}

func DLogb(_ num: UInt)
{
    #if DEBUG
        print(String(num, radix: 2))
    #endif
}

func DLogb(_ num: Int)
{
    #if DEBUG
        print(String(num, radix: 2))
    #endif
}



func DLog(_ object: AnyObject?)
{
    #if DEBUG
    guard let object = object else { return }
    print(object)
    #endif
}

func DLog(_ object: Any?)
{
    #if DEBUG
    guard let object = object else { return }
    print(object)
    #endif
}

func DLog(_ object: Error?)
{
    #if DEBUG
    guard let object = object else { return }
    print(object)
    #endif
}

public func DTrack(_ message: String? = nil, file: String = #file, function: String = #function, line: Int = #line ) {
    if message == nil {
        DLog("Called from \(function) \(file):\(line)")
    } else {
        DLog("\(message!) called from \(function) \(file):\(line)")
    }
}
