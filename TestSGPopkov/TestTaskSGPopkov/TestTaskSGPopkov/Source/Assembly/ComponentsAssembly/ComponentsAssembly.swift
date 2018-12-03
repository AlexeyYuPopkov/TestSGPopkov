//
//  ComponentsAssembly.swift
//
//
//  Created by Alexey Popkov on 11/29/16.
//  Copyright © 2016 Alexey Popkov. All rights reserved.
//

import Foundation

final class ComponentsAssembly: ComponentsAssemblyProtocol
{
    static let shared: ComponentsAssemblyProtocol = ComponentsAssembly()
    lazy var instancesManager = RegisteredInstancesManager()

    private init() { }
}

// MARK: ComponentsAssemblyManagersProtocol

extension ComponentsAssembly
{
    var networkClient: NetworkClientProtocol {
        let constructor: AnyObjectConstructor = { [unowned self] () -> AnyObject in
            return NetworkClient(mapper: self.networkClientObjectMapper)
        }

        return instancesManager.instanceForClass(NetworkClient.self,
                                                 constructor: constructor) as! NetworkClientProtocol
    }

    var networkClientObjectMapper: NetworkClientObjectMapper {
        let constructor: AnyObjectConstructor = { () -> AnyObject in
            return NetworkClientObjectMapper()
        }

        return instancesManager.instanceForClass(NetworkClientObjectMapper.self,
                                                 constructor: constructor) as! NetworkClientObjectMapper
    }
}


