//
//  HomeBannerModel.swift
//  HT_Shopping
//
//  Created by 陈竹青 on 2020/11/19.
//

import Foundation
import HandyJSON

struct HomeBanner : HandyJSON {
    var code : String?
    var msg : String?
    var data : [BannerItem]?

}

struct BannerItem : HandyJSON{
    var ios_action : String?
    var id : String?
    var wh_rate : String?
    var wapImg : String?
}
