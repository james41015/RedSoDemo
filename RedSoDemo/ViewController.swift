//
//  ViewController.swift
//  RedSoDemo
//
//  Created by Hong James on 2019/8/23.
//  Copyright © 2019 Hong James. All rights reserved.
//

import UIKit
import SnapKit
import Kingfisher

class ViewController: UIViewController {
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.black
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.isPagingEnabled = true
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initUI()
        self.collectionView.register(FeedCollectionViewCell.self, forCellWithReuseIdentifier: String(describing: FeedCollectionViewCell.self))
        self.collectionView.register(RangersCollectionViewCell.self, forCellWithReuseIdentifier: String(describing: RangersCollectionViewCell.self))
        self.collectionView.register(ElasticCollectionViewCell.self, forCellWithReuseIdentifier: String(describing: ElasticCollectionViewCell.self))
        self.collectionView.register(DynamoCollectionViewCell.self, forCellWithReuseIdentifier: String(describing: DynamoCollectionViewCell.self))
    }

    lazy var menuBar: MenuBar = {
        let menuBar = MenuBar()
        menuBar.viewController = self
        return menuBar
    }()
    
    private func initMenuBar() {
        self.view.addSubview(menuBar)
//        self.menuBar.menuClickCallback = { (selectedIndex, selectedTeam) in
//            self.scrollMenuToIndex(index: selectedIndex)
//            if !(selectedTeam == self.team) {
//                self.team = selectedTeam
//                self.page = 0
//                self.viewModel.getRequest(team: selectedTeam, page: self.page, completionHandler: { (resultResponseModel, error) in
//                    self.resultsArray.removeAll()
//                    self.updateResultsArray(resultResponseModel)
//                })
//            }
//        }
        self.menuBar.snp.makeConstraints { (make) in
            make.top.equalTo(self.view.snp.top)
            make.left.equalTo(self.view.snp.left)
            make.right.equalTo(self.view.snp.right)
            make.height.equalTo(50)
        }
    }
    
    func initUI() {
        self.initMenuBar()
        self.collectionView.backgroundColor = UIColor.black
        let titleLabel = UILabel()
        let navTitle = NSMutableAttributedString(string: "Red", attributes:[
            NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 26.0),
            NSAttributedString.Key.foregroundColor: UIColor.white])
        navTitle.append(NSMutableAttributedString(string: "So", attributes:[
            NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 26.0),
            NSAttributedString.Key.foregroundColor: UIColor.red]))
        titleLabel.attributedText = navTitle
        self.navigationItem.titleView = titleLabel
        self.navigationController?.navigationBar.isTranslucent = false
        
        self.view.addSubview(self.collectionView)
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        
        self.collectionView.snp.makeConstraints { (make) in
            make.top.equalTo(self.menuBar.snp.bottom)
            make.left.equalTo(self.view.snp.left)
            make.right.equalTo(self.view.snp.right)
            make.bottom.equalTo(self.view.snp.bottom)
        }
    }
    
    func scrollMenuToIndex(index: Int) {
        let indexPath = IndexPath(row: index, section: 0)
        self.collectionView.scrollToItem(at: indexPath, at: [], animated: true)
    }
    
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.item {
        case 0:
            let cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: RangersCollectionViewCell.self), for: indexPath) as! RangersCollectionViewCell
            cell.team = self.menuBar.titleArray[indexPath.row].lowercased()
            return cell
        case 1:
            let cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: ElasticCollectionViewCell.self), for: indexPath) as! ElasticCollectionViewCell
            cell.team = self.menuBar.titleArray[indexPath.row].lowercased()
            return cell
        case 2:
            let cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: DynamoCollectionViewCell.self), for: indexPath) as! DynamoCollectionViewCell
            cell.team = self.menuBar.titleArray[indexPath.row].lowercased()
            return cell
        default:
            return UICollectionViewCell()
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.menuBar.horizontalBarView.snp.updateConstraints { (make) in
            make.left.equalTo(scrollView.contentOffset.x / 3)
        }
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let index = targetContentOffset.pointee.x / self.view.frame.width
        let indexPath = IndexPath(item: Int(index), section: 0)
        self.menuBar.collectionView.selectItem(at: indexPath, animated: true, scrollPosition: [])
        
        
    }

}

extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width, height: self.collectionView.frame.height)
    }
}

