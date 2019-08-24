//
//  MenuBar.swift
//  RedSoDemo
//
//  Created by Hong James on 2019/8/24.
//  Copyright © 2019 Hong James. All rights reserved.
//

import Foundation
import UIKit

class MenuBar: UIView {
    var horizontalBarView = UIView()
    let titleArray = ["Rangers", "Elastic" , "Dynamo"]
    var menuClickCallback: ((_ selectedTeam: String) -> ())?
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.black
        collectionView.delegate = self
        collectionView.dataSource = self
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.collectionView.register(MenuCollectionViewCell.self, forCellWithReuseIdentifier: String(describing: MenuCollectionViewCell.self))
        self.addSubview(collectionView)
        self.collectionView.snp.makeConstraints { (make) in
            make.top.equalTo(self.snp.top)
            make.left.equalTo(self.snp.left)
            make.right.equalTo(self.snp.right)
            make.bottom.equalTo(self.snp.bottom)
        }
        let selectedIndexPath = IndexPath(row: 0, section: 0)
        self.collectionView.selectItem(at: selectedIndexPath, animated: false, scrollPosition: [])
        self.initHorizontalBar()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func initHorizontalBar() {
        
        self.horizontalBarView.backgroundColor = UIColor.red
        self.addSubview(horizontalBarView)
        self.horizontalBarView.snp.makeConstraints { (make) in
            make.height.equalTo(self.snp.height).dividedBy(8)
            make.left.equalTo(self.snp.left)
            make.bottom.equalTo(self.snp.bottom)
            make.width.equalTo(self.snp.width).dividedBy(3)
        }
    }
    
}

extension MenuBar: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return titleArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: MenuCollectionViewCell.self), for: indexPath) as! MenuCollectionViewCell
        cell.backgroundColor = UIColor.black

        let attrs = [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 20)]
        let attributedString = NSMutableAttributedString(string:self.titleArray[indexPath.row], attributes:attrs)
        let normalString = NSMutableAttributedString(string:self.titleArray[indexPath.row])
        
        cell.titleLabel.attributedText = cell.isHighlighted ? attributedString : normalString
        cell.titleLabel.attributedText = cell.isSelected ? attributedString : normalString
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let x = CGFloat(indexPath.item) * frame.width / 3
        self.horizontalBarView.snp.updateConstraints { (make) in
            make.left.equalTo(x)
        }
        UIView.animate(withDuration: 0.75, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.layoutIfNeeded()
        }, completion: nil)
        self.menuClickCallback?(self.titleArray[indexPath.row].lowercased())
    }
}

extension MenuBar: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.frame.width / CGFloat(titleArray.count), height: self.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
