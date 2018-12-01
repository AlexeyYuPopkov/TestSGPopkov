//
//  RegisteredInstancesManager.swift
//  
//
//  Created by Alexey Popkov on 3/14/17.
//  Copyright © 2017 Alexey Popkov. All rights reserved.
//

import Foundation

protocol RegisteredInstanceProtocol: class {
    var instance: AnyObject? { get }
    var className: String { get }
    var description: String { get }
}

final private class WeakRegisteredInstance: RegisteredInstanceProtocol
{
    weak var instance: AnyObject?
    
    init(instance: AnyObject) {
        self.instance = instance
    }
    
    var className: String {
        return (instance == nil) ? "Undefined Nil" : StringHelper.classNameForObject(instance!)
    }
    
    var description: String {
        return "Weak Instance of Class: \(className)"
    }
}

final private class StrongRegisteredInstance: RegisteredInstanceProtocol
{
    var instance: AnyObject?
    
    init(instance: AnyObject) {
        self.instance = instance
    }
    
    var className: String {
        return (instance == nil) ? "Undefined Nil" : StringHelper.classNameForObject(instance!)
    }
    
    var description: String {
        return "Weak Instance of Class: \(className)"
    }
}

typealias AnyObjectConstructor = (() -> AnyObject)

final class RegisteredInstancesManager
{
    private lazy var registeredInstances = Dictionary<String, RegisteredInstanceProtocol>()
}

// MARK: Public

extension RegisteredInstancesManager
{
    func instanceForClass(_ aClass : AnyClass,
                          isStrong: Bool = false,
                          constructor: AnyObjectConstructor) -> AnyObject
    {
        let className = StringHelper.stringForClass(aClass)
        
        if let instance = registeredInstances[className]?.instance {
            return instance
        }
        
        let instance = constructor()
        var result: RegisteredInstanceProtocol!
        
        if isStrong == true {
            result = StrongRegisteredInstance(instance: instance)
        } else {
            result = WeakRegisteredInstance(instance: instance)
        }
        
        registerInstance(instance: result, forClassName: className)
        
        return instance
    }
    
    var stateDescription: String {
        
        guard registeredInstances.count > 0 else {
            return "Not a single object is registered"
        }
        
        var result = [String]()
        
        for (_, instance) in registeredInstances {
            result.append(instance.description)
        }
        
        return result.joined(separator: "\n")
    }
}

// MARK: Private

extension RegisteredInstancesManager
{
    private func registerInstance(instance: RegisteredInstanceProtocol,
                                  forClassName: String) {
        registeredInstances[forClassName] = instance
    }
    
    private func registeredInstance(forClassName: String) -> RegisteredInstanceProtocol?
    {
        guard let result = registeredInstances[forClassName] else {
            return nil
        }
        
        return result
    }
}
