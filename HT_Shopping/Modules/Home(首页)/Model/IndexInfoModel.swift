//
//  IndexInfoModel.swift
//  HT_Shopping
//
//  Created by 陈竹青 on 2020/11/23.
//

import UIKit
import HandyJSON
class IndexInfoModel: HandyJSON {
    var ios_action : String?
    var maxversion : String?
    var wh_rate : String?
    var link : String?
    var logtitle: String?
    var imgUrl: String?
    var groupsort : String?
    var title: String?
    var sectionId : String?
    var needlogin: String?
    var priority: String?
    var minversion: String?
    var groupid: String?
    var promotionIds: String?
    var devicetype : String?
    //
    var uTehuiIcon: String?
    var uQianGouIcon: String?
    
    required init() {
        
    }
    
}

class RecommendInfo : HandyJSON{
    var returnCode : String?
    var returnMessage : String?
    var indexInfo : Array<IndexInfoModel>?
    
    required init() {
        
    }
    
}
