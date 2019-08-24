//
//  MenuCollectionViewCell.swift
//  RedSoDemo
//
//  Created by Hong James on 2019/8/24.
//  Copyright © 2019 Hong James. All rights reserved.
//

import UIKit

class MenuCollectionViewCell: UICollectionViewCell {
    
    let titleLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(titleLabel)
        self.initUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initUI() {
        self.titleLabel.textAlignment = .center
        self.titleLabel.textColor = UIColor.white
        self.titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.snp.top)
            make.left.equalTo(self.snp.left)
            make.right.equalTo(self.snp.right)
            make.bottom.equalTo(self.snp.bottom)
        }
    }
    
    override var isHighlighted: Bool {
        didSet {

            let attrs = [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 20)]
            let attributedString = NSMutableAttributedString(string:self.titleLabel.text ?? "", attributes:attrs)
            let normalString = NSMutableAttributedString(string:self.titleLabel.text ?? "")

            self.titleLabel.attributedText = isHighlighted ? attributedString : normalString
        }
    }
    
    override var isSelected: Bool {
        didSet {
            let attrs = [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 20)]
            let attributedString = NSMutableAttributedString(string:self.titleLabel.text ?? "", attributes:attrs)
            let normalString = NSMutableAttributedString(string:self.titleLabel.text ?? "")
          
            self.titleLabel.attributedText = self.isSelected ? attributedString : normalString
        }
    }
}
