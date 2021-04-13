//
//  ModuleDatToAction.swift
//  HT_Shopping
//
//  Created by 陈竹青 on 2020/11/24.
//

import UIKit

class ModuleDatToAction: NSObject {
     class func canInputData(min : String?, max: String?, device: String?, version: String?) -> Bool{
        var isCanUser : Bool = false        
        if let minV = min, let maxV = max, let dev = device, let v = version {
            let minVArray = minV.split(separator: "&")
            let maxVArray = maxV.split(separator: "&")
            let currentVersion = Int(v) ?? 0
            let isDevice = Int(dev) == 0 || Int(dev) == 2
            if minVArray.count > 1 && maxVArray.count > 1 {
                let minVersion = Int(minVArray[1]) ?? 0
                let maxVersion = Int(maxVArray[1]) ?? 9999
                let isVersion = (currentVersion >= minVersion) && (currentVersion <= maxVersion)
                if isVersion && isDevice{
                    isCanUser = true
                }
            }else {
                let minVersion = Int(minVArray[0]) ?? 0
                let maxVersion = Int(maxVArray[0]) ?? 9999
                let isVersion = (currentVersion >= minVersion) && (currentVersion <= maxVersion)
                if isVersion && isDevice{
                    isCanUser = true
                }
            }
        }
        return isCanUser
    }
}
