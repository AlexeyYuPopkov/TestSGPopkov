//
//  SelectUserVCVMProtocol.swift
//  TestTaskSGPopkov
//
//  Created by Alexey Popkov on 12/3/18.
//  Copyright © 2018 Alexey Popkov. All rights reserved.
//

import Foundation
import RxSwift
import RxDataSources

protocol SelectedUsersListVCVMProtocol: MessageVCVMProtocol
{
    var selectUsersDataSource: RxCollectionViewSectionedAnimatedDataSource<CommonRxDataSourceModels.Section>! { get set }
    var selectedUsersSubj: BehaviorSubject<[CommonRxDataSourceModels.Section]> { get }
    func removeRow(_ row: CommonRxDataSourceModels.Row)
}

protocol UsersListVCVMProtocol
{
    var dataSource: RxTableViewSectionedAnimatedDataSource<CommonRxDataSourceModels.Section>! { get set }
    var userListSectionsSubj: BehaviorSubject<[CommonRxDataSourceModels.Section]> { get }
    
    func userDidSelected()
    
    func load()
}

protocol MessageVCVMProtocol
{
    var selectedUsersSubj: BehaviorSubject<[CommonRxDataSourceModels.Section]> { get }
    func didSendButtonTapped()
}
