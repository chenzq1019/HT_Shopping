//
//  API.swift
//  HT_Shopping
//
//  Created by 陈竹青 on 2020/11/19.
//

import Foundation



struct APIItem: HWAPIProtocol {
    var baseHeader: [String : String]?
    var url: String { API.Domain + URLPath}
    let description: String
    let extra: String?
    var method: HWHTTPMethod

    private let URLPath: String  // URL的path

    init(_ path: String, d: String, e: String? = nil, m: HWHTTPMethod = .get) {
        URLPath = path
        description = d
        extra = e
        method = m
        baseHeader = ["app_version":getAppVersion(),
                      "version_no":getAppVersion(),
                      "client_type":clientType,
                      "market_id":marketID,
                      "appkey":appKey,
                      "session_id":"",
                      "user_token":"",]
    }

    init(_ path: String, m: HWHTTPMethod) {
        self.init(path, d: "", e: nil, m: m)
    }
}

struct API {
    static var Domain = ""
    struct Home {
        static var p_code = "310000"
        static var banner : APIItem = APIItem(kCDNDomain + "/mobilead/v2/recommend/queryAppRecBanner/" + p_code + "/app",d: "首页banner",m: .get)
        static var list : APIItem = APIItem(kCDNDomain + "/mobilead/v2/recommend/listingRecommentGet/app/ule_index_guess_like_" + p_code + "/null/null/0.html",d: "首页底部商品列表",m: .get)
        static var floor : APIItem = APIItem(kCDNDomain + "/mobilead/v2/recommend/queryAppRecFloor/" + p_code + "/app",d: "首页楼层数据",m: .get)
        static var midleModule : APIItem = APIItem(kCDNDomain + "/mobilead/v2/recommend/featuredGets/app/0/ule_index_2nd_" + p_code + "-ule_index_3rd_" + p_code + "-ule_index_5th_" + p_code + "/null.html", m: .get)
        
    }
}
