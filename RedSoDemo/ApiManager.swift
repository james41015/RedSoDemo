//
//  ApiManager.swift
//  RedSoDemo
//
//  Created by Hong James on 2019/8/23.
//  Copyright © 2019 Hong James. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper

class ApiManager {
    static let sharedInstance = ApiManager()
    
    func getRequest<T>(url: String ,parameters: Parameters ,completionHandler: @escaping (RootResponseModel<T>?, NSError?) -> ()) -> DataRequest {
        return request(method: .get, url: url, parameters: parameters, completionHandler: completionHandler)
    }
    
    private func request<T>(method: HTTPMethod, url: String ,parameters: Parameters ,completionHandler: @escaping (RootResponseModel<T>?, NSError?) -> ()) -> DataRequest {
        return Alamofire.request(url, method: method, parameters: parameters, encoding: URLEncoding.default).responseJSON { (response) in
            switch response.result {
            case .success(_):
                let responseRootModel = Mapper<RootResponseModel<T>>().map(JSON: response.result.value as! [String : Any])
                completionHandler(responseRootModel,nil)
            case .failure(let error):
                completionHandler(nil, error as NSError)
            }
        }
    }
}

