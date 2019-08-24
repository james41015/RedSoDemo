//
//  ElasticCollectionViewCell.swift
//  RedSoDemo
//
//  Created by Hong James on 2019/8/25.
//  Copyright © 2019 Hong James. All rights reserved.
//

import Foundation
import Alamofire

class ElasticCollectionViewCell: FeedCollectionViewCell {
    override func getRequest(team: String) -> DataRequest {
        return self.viewModel.getRequest(team: "elastic", page: self.page) { (resultResponseModel, error) in
            self.resultsArray.removeAll()
            self.updateResultsArray(resultResponseModel)
        }
    }
}
