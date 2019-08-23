//
//  ViewController.swift
//  RedSoDemo
//
//  Created by Hong James on 2019/8/23.
//  Copyright © 2019 Hong James. All rights reserved.
//

import UIKit
import SnapKit

class ViewController: UIViewController {

    let tableView = UITableView()
    let viewModel = ViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initUI()
        self.viewModel.getRequest(team: "rangers", page: 0) { (resultResponseModelArray, error) in
            print(resultResponseModelArray)
        }
    }

    func initUI() {
        self.navigationItem.title = "RedSo"
        
        self.view.addSubview(self.tableView)
        self.tableView.delegate = self
        
        self.tableView.snp.makeConstraints { (make) in
            make.top.equalTo(self.view.snp.top)
            make.left.equalTo(self.view.snp.left)
            make.right.equalTo(self.view.snp.right)
            make.bottom.equalTo(self.view.snp.bottom)
        }
    }

}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    
}
