//
//  UsersListVCVM.swift
//  TestTaskSGPopkov
//
//  Created by Alexey Popkov on 12/1/18.
//  Copyright © 2018 Alexey Popkov. All rights reserved.
//

import Foundation
import RxSwift
import RxDataSources

fileprivate let Limit = 2

final class UsersListVCVM
{
    private let network: NetworkClientUsersProtocol
    
    var dataSource: RxTableViewSectionedAnimatedDataSource<Section>!
    var targetVC: UsersListVC?
    
    private let disposeBag = DisposeBag()
    
    lazy var sectionBehaviorSubj = BehaviorSubject(value: [Section]())
    
    private lazy var maxUserId: Int? = nil
    
    init(networkClient: NetworkClientUsersProtocol)
    {
        self.network = networkClient
    }
    
    func load() {
        network.getUsers(lastUserId: maxUserId, limit: Limit)
            .throttle(2.0, scheduler: MainScheduler.instance)
            .subscribe { [weak self] event in
                switch event {
                case .next(let items):
                    if let sections = self?.createSectionsWithUsers(items) {
                        self?.sectionBehaviorSubj.onNext(sections)
                    }
                case .error(_):
                    self?.targetVC?.showAlert(message: "Error")
                case .completed:
                    break
                }
        }.disposed(by: disposeBag)
    }
}

// MARK: Sections

extension UsersListVCVM
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
