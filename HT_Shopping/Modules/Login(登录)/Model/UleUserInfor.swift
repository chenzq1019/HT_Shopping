//
//  UleUserInfor.swift
//  HT_Shopping
//
//  Created by 陈竹青 on 2021/9/14.
//

import Foundation
import HandyJSON

let kUserID = "userInfor_ID"
let kUserName = "userInfo_Name"
let kUserToken = "userInfo_Token"
let kBindMobile = "userInfo_bindMobile"
let kUserMobile = "userInfo_Mobile"
let kUsrRank  = "userInfo_UsrRank"
let kUserEmail = "userInfo_Email"

class UserClassModel : NSObject,NSCoding,HandyJSON{
    func encode(with coder: NSCoder) {
        coder.encode(userID, forKey: "userID")
        coder.encode(bindMobile, forKey: "bindMobile")
        coder.encode(userMobile, forKey: "userMobile")
        coder.encode(userName, forKey: "userName")
        coder.encode(userToken, forKey: "userToken")
        coder.encode(usrRank, forKey: "usrRank")
        coder.encode(userEmail, forKey: "userEmail")
        coder.encode(openfirePwd, forKey: "openfirePwd")
        coder.encode(openfireName, forKey: "openfireName")
        coder.encode(openId, forKey: "openId")
        coder.encode(dgFlag, forKey: "dgFlag")
        coder.encode(appleLoginSkipFlag, forKey: "appleLoginSkipFlag")
        
    }
    
    required init?(coder: NSCoder) {
   
        self.userID = (coder.decodeObject(forKey: "userID") as! String)
        self.bindMobile = (coder.decodeObject(forKey: "bindMobile") as! String)
        self.userMobile = (coder.decodeObject(forKey: "userMobile") as! String)
        self.userName = (coder.decodeObject(forKey: "userName") as! String)
        self.userToken = (coder.decodeObject(forKey: "userToken") as! String)
        self.usrRank = (coder.decodeObject(forKey: "usrRank") as! String)
        self.userEmail = (coder.decodeObject(forKey: "userEmail") as! String)
        self.openfirePwd = (coder.decodeObject(forKey: "openfirePwd") as! String)
        self.openfireName = (coder.decodeObject(forKey: "openfireName") as! String)
        self.openId = (coder.decodeObject(forKey: "openId") as! String)
        self.dgFlag = (coder.decodeObject(forKey: "dgFlag") as! String)
        self.appleLoginSkipFlag = (coder.decodeObject(forKey: "appleLoginSkipFlag") as! String)
        super.init()
    }
    
    var userID : String
    var bindMobile : String
    var userMobile : String
    var userName : String
    var userToken : String
    var usrRank : String
    var userEmail : String
    var openfirePwd : String
    var openfireName : String
    var openId : String
    var dgFlag : String
    var appleLoginSkipFlag : String
    
    required override init() {
        self.userID = ""
        self.bindMobile = ""
        self.userMobile = ""
        self.userName = ""
        self.usrRank = ""
        self.userEmail = ""
        self.userToken = ""
        self.openfirePwd = ""
        self.openfireName = ""
        self.openId = ""
        self.dgFlag =  ""
        self.appleLoginSkipFlag = ""
        super.init()
    }
}


class UleUserInfor  {
    static let share = UleUserInfor()
    var headIconUrl : String? {
        set(value){
            UserDefaults.standard.setValue(value, forKey: "headImageUrl")
        }
        get{
            return UserDefaults.standard.object(forKey: "headImageUrl") as? String
        }
    }
    var user : UserClassModel!
    var isLogin : Bool {
        get{
            if let user = user ,user.userID.count > 0 {
                return true
            }else{
                return false
            }
        }
    }
    init() {
        let dataFrom = UserDefaults.standard.data(forKey: "UserInfor")
        if let from = dataFrom {
            do {
                user = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(from) as? UserClassModel
                
            }catch{
                print("序列化错误 ==== read")
            }
        }

    }

    static func save(userInfo: UserClassModel?) {
        UleUserInfor.share.user = userInfo
        if let user = userInfo {
            do {
                let data = try NSKeyedArchiver.archivedData(withRootObject: user, requiringSecureCoding: false)
                UserDefaults.standard.setValue(data, forKey: "UserInfor")
                UserDefaults.standard.synchronize()
                
            }catch{
                print("序列化错误==== ave")
            }
        }
    }
    static func logOut(){
        
    }
}
