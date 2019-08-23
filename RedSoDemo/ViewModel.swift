//
//  ViewModel.swift
//  RedSoDemo
//
//  Created by Hong James on 2019/8/23.
//  Copyright © 2019 Hong James. All rights reserved.
//

import Foundation
import Alamofire

class ViewModel {
    
    let domain = "https://us-central1-redso-challenge.cloudfunctions.net"
    let endPoint = "/catalog"
    
    func getRequest(team: String, page: Int, completionHandler: @escaping (RootResponseModel<ResultResponseModel>?, NSError?) -> ()) -> DataRequest {
        
        let url = domain + endPoint
        let parameters: Parameters = [
            "team": team,
            "page": page
        ]
        
        let request = ApiManager.sharedInstance.getRequest(url: url, parameters: parameters, completionHandler: completionHandler)
        
        return request
    }
}
