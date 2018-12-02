//
//  SelectedUsersListVC.swift
//  TestTaskSGPopkov
//
//  Created by Alexey Popkov on 12/1/18.
//  Copyright © 2018 Alexey Popkov. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

class SelectedUsersListVC: BaseCollectionVC, LayoutHelperProtocol
{
    typealias Section = CommonRxDataSourceModels.Section
    var vm: SelectedUsersListVCVMProtocol!
    
    var disposeBag: DisposeBag!
    
    lazy var noDataLabel: UILabel = {
        let result = UILabel(frame: CGRect.zero)
        result.textAlignment = .center
        result.text = "No users selected"
        return result
    }()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = nil
        
        vm.selectUsersDataSource = self.createDataSource()
        
        vm.selectedUsersSubj
            .do(onNext: { [weak self] sections in
                guard let `self` = self else { return }

                if sections.count > 0 && sections[0].items.count > 0 {
                    self.noDataLabel.removeFromSuperview()
                    self.noDataLabel.isHidden = true
                } else {
                    self.view.addSubview(self.noDataLabel)
                    self.addAnchors(to: self.noDataLabel, withSuperview: self.view)
                    self.noDataLabel.isHidden = false
                }
            })
            .bind(to: collectionView.rx.items(dataSource: vm.selectUsersDataSource))
            .disposed(by: disposeBag)
    }
    
    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if let cell = cell as? CollectionUserCell {
            let row = vm.selectUsersDataSource.sectionModels[0].items[indexPath.row]
            cell.handleTap = { [weak self] cell in
                self?.vm.removeRow(row)
            }
        }
    }
}

// MARK: Create Data Source

extension SelectedUsersListVC
{
    func createDataSource() -> RxCollectionViewSectionedAnimatedDataSource<Section> {
        let result = RxCollectionViewSectionedAnimatedDataSource<Section>(
            animationConfiguration: AnimationConfiguration(insertAnimation: .top,
                                                           reloadAnimation: .fade,
                                                           deleteAnimation: .left),
            configureCell: { dataSource, collectionView, indexPath, item in
                switch dataSource[indexPath.section].itemsType {
                case .user:
                    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionUserCell", for: indexPath) as! CollectionUserCell
                    cell.vm = item.model as? UserVM
                    return cell
                }
        },
            configureSupplementaryView: { (_, _, _, _) in
                return UICollectionReusableView(frame: CGRect.zero)
        })

        return result
    }
}
