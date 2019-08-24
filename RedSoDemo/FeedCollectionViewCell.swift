//
//  FeedCollectionViewCell.swift
//  RedSoDemo
//
//  Created by Hong James on 2019/8/24.
//  Copyright © 2019 Hong James. All rights reserved.
//

import UIKit
import Alamofire

class FeedCollectionViewCell: UICollectionViewCell {
    let tableView = UITableView()
    
    let viewModel = ViewModel()
    var resultsArray = [ResultResponseModel]()
    var tryToLoadNextPage = false
    var isLoadingNextPage = false
    var page = 0
    var team = "rangers"
    let refreshControl = UIRefreshControl()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.tableView.register(ResultTableViewCell.self, forCellReuseIdentifier: String(describing: ResultTableViewCell.self))
        self.tableView.register(BannerTableViewCell.self, forCellReuseIdentifier: String(describing: BannerTableViewCell.self))
        self.tableView.backgroundColor = UIColor.black
        self.tableView.addSubview(refreshControl)
        self.refreshControl.addTarget(self, action: #selector(refreshData), for: UIControl.Event.valueChanged)
        self.addSubview(self.tableView)
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.tableView.snp.makeConstraints { (make) in
            make.top.equalTo(self.contentView)
            make.left.equalTo(self.contentView.snp.left)
            make.right.equalTo(self.contentView.snp.right)
            make.bottom.equalTo(self.contentView.snp.bottom)
        }
        self.getRequest(team: self.team)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func getRequest(team: String) -> DataRequest {
        return self.viewModel.getRequest(team: team, page: self.page) { (resultResponseModel, error) in
            self.resultsArray.removeAll()
            self.updateResultsArray(resultResponseModel)
        }
    }
    
    func updateResultsArray(_ resultResponseModel: RootResponseModel<ResultResponseModel>?) {
        if let resultResponse = resultResponseModel?.results {
            self.tryToLoadNextPage = (resultResponse.count == 0) ? false : true
            for result in resultResponse {
                self.resultsArray.append(result)
            }
        }
        self.tableView.reloadData()
    }
    
    private func loadNextPage() {
        self.isLoadingNextPage = true
        self.page += 1
        self.viewModel.getRequest(team: self.team, page: self.page) { (resultResponseModel, error) in
            self.isLoadingNextPage = false
            self.updateResultsArray(resultResponseModel)
        }
    }
    
    @objc private func refreshData() {
        self.page = 0
        self.viewModel.getRequest(team: self.team, page: self.page) { (resultResponseModel, error) in
            self.refreshControl.endRefreshing()
            self.resultsArray.removeAll()
            self.updateResultsArray(resultResponseModel)
        }
    }
}

extension FeedCollectionViewCell: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return resultsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let model = self.resultsArray[indexPath.row]
        if let type = model.type {
            let rowsToLoadFromBottom = 2;
            let rowsLoaded = resultsArray.count
            if tryToLoadNextPage == true {
                if (!isLoadingNextPage && (indexPath.row >= (rowsLoaded - rowsToLoadFromBottom))) {
                    self.loadNextPage()
                }
            }
            switch type {
            case "employee":
                let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ResultTableViewCell.self), for: indexPath) as! ResultTableViewCell
                if let urlString = model.avatar {
                    let imageUrl = URL(string: urlString)
                    cell.resultImageView.kf.setImage(with: imageUrl)
                }
                
                cell.nameLabel.text = model.name
                cell.positionLabel.text = model.position
                cell.expertiseLabel.text = model.expertise!.joined(separator: ",")
                cell.selectionStyle = .none
                
                return cell
            case "banner":
                let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: BannerTableViewCell.self), for: indexPath) as! BannerTableViewCell
                if let urlString = model.url {
                    let imageUrl = URL(string: urlString)
                    cell.bannerImageView.kf.setImage(with: imageUrl)
                }
                cell.selectionStyle = .none
                return cell
            default:
                return UITableViewCell()
            }
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let model = self.resultsArray[indexPath.row]
        if let type = model.type {
            switch type {
            case "employee":
                return 150
            case "banner":
                return 200
            default:
                return 0
            }
        }
        return 0
    }
}

