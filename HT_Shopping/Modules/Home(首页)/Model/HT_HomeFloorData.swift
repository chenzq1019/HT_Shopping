//
//  HT_HomeFloorData.swift
//  HT_Shopping
//
//  Created by 陈竹青 on 2020/11/20.
//

import UIKit
import HandyJSON

class HT_HomeFloorData: HandyJSON {
    required init() {
        
    }
    
    var code : String?
    var msg : String?
    var groupsort : String?
    var data : [HT_FloorItem]?
}

class HT_FloorItem: HandyJSON {
    required init() {
        
    }
    
    var priority : String?
    var floorName : String?
    var floorIcon : String?
    var titleColor : String?
    var list : [HT_FloorPrd]?
}

class HT_FloorPrd: HandyJSON {
    
    var floorId : String?
    var listingId : String?
    var title : String?
    var imgUrl : String?
    var customPrice : String?
    var ios_action : String?
    required init() {
        
    }
}


