//
//  StringHelper.swift
//
//
//  Created by Alexey Popkov on 12/2/16.
//  Copyright © 2016 Alexey Popkov. All rights reserved.
//

import UIKit

public class StringHelper
{
    public static func stringForClass(_ aClass : AnyClass) -> String {
        return String(describing: aClass.self)
    }
    
    public static func classNameForObject(_ obj: Any) -> String
    {
        let result = String(describing: type(of: obj))
        return result
    }
}

extension StringHelper
{
    public static func stringOrEmpty(_ string: String?) -> String {
        if let theString = string {
            return theString
        } else {
            return ""
        }
    }

    public static func trimmedString(_ string: String) -> String {
        return string.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    }
}

// MARK:
// MARK: NSAttributedString

private extension Array where Element: NSAttributedString
{
    func joined(separator: NSAttributedString) -> NSAttributedString {
        var isFirst = true
        return self.reduce(NSMutableAttributedString()) {
            (r, e) in
            if isFirst {
                isFirst = false
            } else {
                r.append(separator)
            }
            r.append(e)
            return r
        }
    }
    
    func joined(separator: String) -> NSAttributedString {
        return joined(separator: NSAttributedString(string: separator))
    }
}

extension StringHelper
{
    public static func joinedAttrString(array: [NSAttributedString],
                                        separator: String) -> NSAttributedString {
        return array.joined(separator: separator)
    }
    
    public static func joinedAttrString(array: [NSAttributedString],
                                        attributedSeparator: NSAttributedString) -> NSAttributedString {
        return array.joined(separator: attributedSeparator)
    }
    
    public static func joined(_ items: [(String?, [NSAttributedString.Key: Any])],
                              separator: String) -> NSAttributedString? {
        return joined(items, attributedSeparator: NSAttributedString(string: separator))
    }
    
    public static func joined(_ items: [(String?, [NSAttributedString.Key: Any])],
                              attributedSeparator: NSAttributedString) -> NSAttributedString?
    {
        let array = items.filter { return $0.0 != nil }
        guard array.count > 0 else { return nil }
        
        let result = NSMutableAttributedString()
        
        var isFirst = true
        
        array.forEach { (str, attrs) in
            if str != nil {
                
                if isFirst {
                    isFirst = false
                } else {
                    result.append(attributedSeparator)
                }
                
                result.append(NSAttributedString(string: str!, attributes: attrs))
            }
        }
        
        return result
    }
    
    public static func attributedStringHeight(_ str: NSAttributedString?, width: CGFloat) -> CGFloat
    {
        guard let str = str else { return CGFloat.leastNormalMagnitude }
        return str.boundingRect(with: CGSize(width: width, height: .greatestFiniteMagnitude),
                                options: .usesLineFragmentOrigin, context: nil).height
    }
}


