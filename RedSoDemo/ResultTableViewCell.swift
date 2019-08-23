//
//  ResultTableViewCell.swift
//  RedSoDemo
//
//  Created by Hong James on 2019/8/23.
//  Copyright © 2019 Hong James. All rights reserved.
//

import UIKit
import SnapKit

class ResultTableViewCell: UITableViewCell {

    var resultImageView = UIImageView()
    var nameLabel = UILabel()
    var positionLabel = UILabel()
    var expertiseLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.addSubview(resultImageView)
        self.contentView.addSubview(nameLabel)
        self.contentView.addSubview(positionLabel)
        self.contentView.addSubview(expertiseLabel)
        
        self.backgroundColor = UIColor.black
        self.resultImageView.contentMode = .scaleAspectFit
        self.nameLabel.textColor = UIColor.white
        self.positionLabel.textColor = UIColor.white
        self.expertiseLabel.textColor = UIColor.white
        self.expertiseLabel.numberOfLines = 0
        
        self.resultImageView.snp.makeConstraints { (make) in
            make.top.equalTo(self.contentView).offset(20)
            make.left.equalTo(self.contentView).offset(20)
            make.right.equalTo(self.nameLabel.snp.left).offset(-20)
            make.bottom.equalTo(self.contentView).offset(-20)
            make.height.equalTo(self.resultImageView.snp.width)
        }
        
        self.nameLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.contentView).offset(20)
            make.left.equalTo(self.resultImageView.snp.right).offset(20)
            make.right.equalTo(self.contentView).offset(-10)
            
        }
        
        self.positionLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.nameLabel.snp.bottom).offset(10)
            make.left.equalTo(self.resultImageView.snp.right).offset(20)
            make.right.equalTo(self.contentView).offset(-10)
            
        }
        
        self.expertiseLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.positionLabel.snp.bottom).offset(10)
            make.left.equalTo(self.resultImageView.snp.right).offset(20)
            make.right.equalTo(self.contentView).offset(-10)
            make.bottom.equalTo(self.contentView).offset(-20)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        self.resultImageView.layer.cornerRadius = self.resultImageView.frame.width / 2
        self.resultImageView.clipsToBounds = true
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
