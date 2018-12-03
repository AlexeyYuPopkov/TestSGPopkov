//
//  SelectUserVCVM.swift
//  TestTaskSGPopkov
//
//  Created by Alexey Popkov on 12/2/18.
//  Copyright © 2018 Alexey Popkov. All rights reserved.
//

import Foundation
import RxSwift
import RxDataSources

fileprivate let Limit = 30

final class SelectUserVCVM: SelectedUsersListVCVMProtocol, UsersListVCVMProtocol
{
    typealias Section = CommonRxDataSourceModels.Section
    typealias Row = CommonRxDataSourceModels.Row
    
    var selectUsersDataSource: RxCollectionViewSectionedAnimatedDataSource<Section>!
    var dataSource: RxTableViewSectionedAnimatedDataSource<Section>!
    var targetVC: SelectUserVC?
    
    private let disposeBag = DisposeBag()
    
    lazy var selectedUsersSubj = BehaviorSubject(value: [Section]())
    lazy var userListSectionsSubj = BehaviorSubject(value: [Section]())
    
    private let network: NetworkClientUsersProtocol
    
    private var maxUserId: Int? = nil
    
    init(networkClient: NetworkClientUsersProtocol)
    {
        self.network = networkClient
    }
}

// MARK: SelectedUsersListVCVMProtocol, MessageVCVMProtocol

extension SelectUserVCVM
{
    func removeRow(_ row: CommonRxDataSourceModels.Row)
    {
        let newItems = selectUsersDataSource.sectionModels[0].items.filter {
            return row.identity != $0.identity
        }
        
        selectedUsersSubj.onNext([Section(items: newItems, itemsType: .user, header: nil)])
        
        dataSource.sectionModels[0].items.forEach { item in
            if item.identity == row.identity {
                (item.model as? UserVM)?.isSelected.onNext(false)
            }
        }
    }
    
    func didSendButtonTapped() {
        selectedUsersSubj.onNext([Section(items: [], itemsType: .user, header: nil)])
        
        dataSource.sectionModels[0].items.forEach { item in
            (item.model as? UserVM)?.isSelected.onNext(false)
        }
    }
}

// MARK: UsersListVCVMProtocol

extension SelectUserVCVM
{
    func load() {
        network.getUsers(lastUserId: maxUserId, limit: Limit)
            .throttle(2.0, scheduler: MainScheduler.instance)
            .subscribe { [weak self] event in
                switch event {
                case .next(let items):
                    if let sections = self?.createSectionsWithUsers(items) {
                        self?.userListSectionsSubj.onNext(sections)
                    }
                case .error(_):
                    self?.targetVC?.showAlert(message: "Error")
                case .completed:
                    break
                }
            }.disposed(by: disposeBag)
    }
    
    func userDidSelected()
    {
        let newSelectedUsers = dataSource.sectionModels[0].items.filter {
            guard let userVM = $0.model as? UserVM else { return false }
            return (try? userVM.isSelected.value()) ?? false
        }
        
        selectedUsersSubj.onNext([Section(items: newSelectedUsers, itemsType: .user, header: nil)])
    }
}

extension SelectUserVCVM
{
    private func createSectionsWithUsers(_ users: [GetUsersResult]) -> [Section] {
        
        self.maxUserId = users.reduce(0, { (result, user) -> Int in
            return max(result, user.id)
        })
        
        let result = users.map { Row(type: .user, model:  UserVM(user: $0)) }
        
        var newSections = dataSource.sectionModels
        
        if let index = newSections.firstIndex(where: { (sect) -> Bool in
            return sect.itemsType == .user
        })
        {
            newSections[index].items.append(contentsOf: result)
            return newSections
        } else {
            newSections.append(Section(items: result, itemsType: .user, header: nil))
            return newSections
        }
    }
}
