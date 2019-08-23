//
//  ResultResponseModel.swift
//  RedSoDemo
//
//  Created by Hong James on 2019/8/23.
//  Copyright © 2019 Hong James. All rights reserved.
//

import Foundation
import ObjectMapper

class ResultResponseModel: NSObject, Mappable {
    
    var id: String?
    var type: String?
    var name: String?
    var position: String?
    var expertise: Array<String>?
    var avatar: String?
    var url: String?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        type <- map["type"]
        name <- map["name"]
        position <- map["position"]
        expertise <- map["expertise"]
        avatar <- map["avatar"]
        url <- map["url"]
    }
    
    
}
