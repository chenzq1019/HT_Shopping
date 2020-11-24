//
//  HT_Config.swift
//  HT_Shopping
//
//  Created by 陈竹青 on 2020/11/19.
//

import Foundation
import UIKit

public let clientType : String = "ule"
public let marketID : String = "015"

public var appKey : String {
    var key : String = ""
    #if BETA
        key = "b9563a085baedf51"
    #elseif PRD
        key = "b9563a085baedf51"
    #endif
    return key
}

public var kServersDomain : String {
    var server: String = ""
    #if BETA
        server = "https://service.beta.ule.com"
    #elseif PRD
        server = "https://service.ule.com"
    #endif
    return server
}

public var kCDNDomain : String {
    var domoain : String = ""
    #if BETA
        domoain = "https://static-content.beta.ulecdn.com"
    #elseif PRD
        domoain = "https://static-content.ulecdn.com"
    #endif
    
    return domoain
}
