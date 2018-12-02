//
//  CommonRxDataSourceModels.swift
//  TestTaskSGPopkov
//
//  Created by Alexey Popkov on 12/2/18.
//  Copyright © 2018 Alexey Popkov. All rights reserved.
//

import Foundation
import RxDataSources

struct CommonRxDataSourceModels
{
    struct Section:
        SectionModelType,
        IdentifiableType,
        AnimatableSectionModelType,
        Equatable
    {
        typealias Item = Row
        typealias Identity = String
        
        enum ItemsType: String {
            case user
            
            var value: String { return rawValue }
        }
        
        var identity: String {
            return itemsType.rawValue
        }
        
        var itemsType: ItemsType
        var header: String?
        var items: [Row]
        
        init(original: Section, items: [Item]) {
            self = original
            self.items = items
        }
        
        init(items: [Item],
             itemsType: ItemsType,
             header: String? = nil)
        {
            self.items = items
            self.itemsType = itemsType
            self.header = header
        }
        
        public static func == (lhs: Section, rhs: Section) -> Bool {
            return lhs.identity == rhs.identity
        }
    }
}

extension CommonRxDataSourceModels
{
    class Row: IdentifiableType, Equatable, Hashable
    {
        typealias Identity = Int
        var model: AnyHashable
        let type: Section.ItemsType
        
        var identity: Identity {
            return type.hashValue ^ model.hashValue
        }
        
        init(type: Section.ItemsType, model: AnyHashable) {
            self.model = model
            self.type = type
        }
        
        var hashValue: Int {
            return identity
        }
        
        public static func == (lhs: Row, rhs: Row) -> Bool {
            return lhs.identity == rhs.identity
        }
    }
}
