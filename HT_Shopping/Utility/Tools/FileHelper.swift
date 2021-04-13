//
//  FileHelper.swift
//  HT_Shopping
//
//  Created by 陈竹青 on 2020/11/30.
//

import Foundation

/**
 *获取doucment路径
 */
public func docmentsPath() -> String? {
    let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
    return path.first
}
/**
 *获取工程中资源文件路径
 */
public func prductPath(fileName: String?,_ type: String?)  -> String? {
    let path = Bundle.main.path(forResource: fileName, ofType: type)
    return path
}

/**
 * 在document文件下，获取自定文件名的路径
 */
public func fullpathOfFileName(fileName: String?) -> String?{
    guard let document = docmentsPath() as NSString? else {
        return nil
    }
    guard let name = fileName else {
        return nil
    }
    return document.appendingPathComponent(name)
}

/**
 *写入文件Dictionary
 *
 */
public func saveDictionary(list: Dictionary<String, Any> , fileName:String) ->Void{
    let filePath = fullpathOfFileName(fileName: fileName)
    let saveList = list as NSDictionary
    if let path = filePath {
        saveList.write(toFile: path, atomically: true)
    }
   
}

/**
 *读取文件Dixtionary
 */
public func loadDictionary(fileName: String) -> Dictionary<String,Any>? {
    let filePath = fullpathOfFileName(fileName: fileName)
    guard let path = filePath else {
        return nil
    }
    let dicInfo = NSDictionary.init(contentsOfFile: path) as? Dictionary<String, Any>
    return dicInfo
}

/**
 * 写入Array
 */
public func saveArrayTofile(array:Array<Any>,fileName: String) ->Void{
    let filePath = fullpathOfFileName(fileName: fileName)
    let saveArray = array as NSArray
    if let path = filePath {
        saveArray.write(toFile: path, atomically: true)
    }
}

/**
 * 从沙盒中读取Array数据
 */
public func loadArrayForName( fileName: String) ->Array<Any>?{
    let filePath = fullpathOfFileName(fileName: fileName)
    guard let path = filePath else {
        return nil
    }
    let arrayInfo = NSArray.init(contentsOfFile: path) as? Array<Any>
    return arrayInfo
}
