//
//  HomeList.swift
//  HT_Shopping
//
//  Created by 陈竹青 on 2020/11/19.
//

import Foundation
import HandyJSON
struct HomeList : HandyJSON{
    var returnCode: String?
    var returnMessage : NSString?
    var ule_index_guess_like : [HomeListItem]?
}
struct HomeListItem: HandyJSON {
    var listingName : String?
    var imgUrl: String?
    var minPrice: String?
    var maxPrice: String?
    
}
