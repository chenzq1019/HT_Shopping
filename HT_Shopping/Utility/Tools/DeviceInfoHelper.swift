//
//  DeviceInfoHelper.swift
//  HT_Shopping
//
//  Created by 陈竹青 on 2020/11/19.
//

import Foundation
import UIKit


public func queryLaunchImage() -> UIImage {
    var lauchImg        : UIImage!
    var viewOrientation : String!
    let viewSize        = UIScreen.main.bounds.size
    let orientation     = UIApplication.shared.statusBarOrientation
    if orientation == .landscapeLeft || orientation == .landscapeRight {
        viewOrientation = "Landscape"
    } else {
        viewOrientation = "Portrait"
    }
    let imageDicArray =  Bundle.main.infoDictionary!["UILaunchImages"]
    
    for dic : Dictionary<String,String> in imageDicArray as! Array {
        let imageSize = NSCoder.cgSize(for: dic["UILaunchImageSize"]!)
        if __CGSizeEqualToSize(imageSize, viewSize) && viewOrientation == dic["UILaunchImageOrientation"]! as String {
            lauchImg = UIImage(named: dic["UILaunchImageName"]!)
        }
    }
    
    return lauchImg
}

public func getAppName() -> String{
    let appName =  Bundle.main.infoDictionary!["CFBundleDisplayName"]
    return appName as? String ?? ""
}

public func getAppVersion() -> String{
    let appVersion = Bundle.main.infoDictionary!["CFBundleShortVersionString"]
    return appVersion as? String ?? ""
}

