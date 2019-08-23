//
//  RootResponseModel.swift
//  RedSoDemo
//
//  Created by Hong James on 2019/8/23.
//  Copyright © 2019 Hong James. All rights reserved.
//

import Foundation
import ObjectMapper

class RootResponseModel<T: Mappable>: NSObject, Mappable {
    
    var results: [T]?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        results <- map["results"]
    }
    
}
