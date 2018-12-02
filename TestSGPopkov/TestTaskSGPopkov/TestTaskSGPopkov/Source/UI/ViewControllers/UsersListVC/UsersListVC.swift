//
//  ViewController.swift
//  TestTaskSGPopkov
//
//  Created by Alexey Popkov on 12/1/18.
//  Copyright © 2018 Alexey Popkov. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

fileprivate var FooterRefreshViewHeight: CGFloat = 30.0

class UsersListVC: BaseTVC, ShowAlertHelperProtocol
{
    typealias VM = UsersListVCVM
    lazy var vm = VM(networkClient: ComponentsAssembly.shared.networkClient)
    let disposeBag = DisposeBag()
    
    lazy var bottomActivityIndicator = UIActivityIndicatorView()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = nil
        
        vm.dataSource = self.createDataSource()
        
        vm.sectionBehaviorSubj
            .do(onNext: { [weak self] _ in
                self?.bottomActivityIndicator.stopAnimating()
                self?.tableView.tableFooterView?.isHidden = true
            })
            .bind(to: tableView.rx.items(dataSource: vm.dataSource))
            .disposed(by: disposeBag)
        
        vm.load()
        
        tableView.rx.contentOffset
//            .subscribeOn(backgroundQueueScheduler)
            .skip(1)
            .throttle(0.5, scheduler: MainScheduler.instance)
            .skipUntil(tableView.rx.didEndDragging)
            .skipUntil(tableView.rx.didEndDecelerating)
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] contentOffset in
                guard let `self` = self else { return }
                let currentOffset = contentOffset.y
                let maximumOffset = self.tableView.contentSize.height - self.tableView.frame.size.height
                let deltaOffset = maximumOffset - currentOffset
                
//                let tableFooterViewIsHidden = self.tableView.tableFooterView?.isHidden
//                let bottomActivityIndicatorIsAnimating = self.bottomActivityIndicator.isAnimating
                
                if deltaOffset <= FooterRefreshViewHeight &&
                    self.tableView.tableFooterView?.isHidden == true &&
                    self.bottomActivityIndicator.isAnimating == false
                {
                    self.tableView.tableFooterView?.isHidden = false
                    self.bottomActivityIndicator.startAnimating()
                    self.vm.load()
                }
                
            }).disposed(by: disposeBag)
        
        configureButtomActivityIndicator()
    }
}

extension UsersListVC
{
    private func configureButtomActivityIndicator()
    {
        let tableFooterView = UIView(frame: CGRect(x: 0.0, y: 0.0,
                                                   width: tableView.bounds.width,
                                                   height: FooterRefreshViewHeight))
        tableFooterView.addSubview(bottomActivityIndicator)
        bottomActivityIndicator.center = tableFooterView.center
        bottomActivityIndicator.style = .gray
        tableView.tableFooterView = tableFooterView
        bottomActivityIndicator.hidesWhenStopped = true
        tableView.tableFooterView?.isHidden = true
    }
    
    func createDataSource() -> RxTableViewSectionedAnimatedDataSource<VM.Section> {
        let result = RxTableViewSectionedAnimatedDataSource<VM.Section>(
            animationConfiguration: AnimationConfiguration(insertAnimation: .top,
                                                           reloadAnimation: .fade,
                                                           deleteAnimation: .left),
            configureCell: { dataSource, tableView, indexPath, item in
                switch dataSource[indexPath.section].itemsType {
                case .user:
                    let cell = tableView.dequeueReusableCell(withIdentifier: "UsersListCell", for: indexPath) as! UsersListCell
                    cell.vm = item.model as? UserVM
                    return cell
                }
        })
        
        return result
    }
}

// MARK: UITableViewDelegate

extension UsersListVC //: UITableViewDelegate
{
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let cell = cell as? UsersListCell {
            cell.handleTap = { cell in
                guard let vm = cell.vm else { return }
                let newValue = try? !vm.isSelected.value()
                vm.isSelected.onNext(newValue ?? false)
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }
}




