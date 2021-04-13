//
//  HT_HomeViewModel.swift
//  HT_Shopping
//
//  Created by 陈竹青 on 2020/11/19.
//

import UIKit

public typealias SuccessBlock = ([AnyObject]) -> Void



let homeGroupDic : [Int : Any] = [21 : HT_HomeGroup(sectionID: "", cellID: "", headSize: CGSize(width: kScreenWidth, height: 50), itemSize: CGSize(width: kScreenWidth, height: kScreenWidth * 4 / 3.0))]

class HT_HomeViewModel: NSObject {
    public var homeHotPrdList: [HomeListItem]?
    
    var requestGroup : DispatchGroup = DispatchGroup()
    var homeTopBannerModel : HomeBanner?
    var homeGroups : [HT_HomeGroup] = Array<HT_HomeGroup>()
    var success : SuccessBlock?
    var homeMorePrd : HT_HomeGroup?
    var homeFloors : [HT_HomeGroup]? = []
    var homeHuiyuan : [HT_HomeGroup]? = []

    func requestHomeBanner() -> Void {
        
        HN.fetch(API.Home.banner, parameters: nil, headers: nil).success { [self] response in
            guard response is [String: AnyObject] else { return }
            if let data = HomeBanner.deserialize(from: response as? Dictionary){
                print("转化为Model了")
                self.homeTopBannerModel = data
            }
            self.requestGroup.leave()
         
        }.failed { (error) in
            print(error)
            self.requestGroup.leave()
        }
    }
    
    func requestAllData(finish : @escaping ()->()) -> Void {
        requestGroup.enter()
        requestHomeBanner()
        requestGroup.enter()
        requestMorePrdList()
        requestGroup.enter()
        requestFloorList()
        requestGroup.enter()
        requestMidModulesInfo()
        requestGroup.notify(queue: DispatchQueue.main) {
            self.homeGroups.removeAll()
            if let more = self.homeMorePrd{
                self.homeGroups.append(more)
            }
            if let floors = self.homeFloors {
                self.homeGroups = self.homeGroups + floors
            }
            
            if let huiyuan = self.homeHuiyuan {
                self.homeGroups =  self.homeGroups + huiyuan
            }
            
            self.homeGroups.sort { (a, b) -> Bool in
                a.priority < b.priority
            }
            finish()
        }
        
    }
    
    public func requestMorePrdList() -> Void{
        
        HN.fetch(API.Home.list, parameters: nil, headers: nil).success {[weak self] (response) in
            if let data = HomeList.deserialize(from: response as? Dictionary) {
                self?.homeHotPrdList = data.ule_index_guess_like ?? nil
                let prdListGroup : HT_HomeGroup = HT_HomeGroup()
                prdListGroup.itemSize = CGSize(width: cellW, height: cellH)
                prdListGroup.headSize = CGSize(width: kScreenWidth, height: 50)
                prdListGroup.sectionID = sectionHeaderId
                prdListGroup.cellID = cellId
                prdListGroup.titleName = "逛一逛"
                prdListGroup.iconImge = "Recommend_icon"
                prdListGroup.priority = 99
                prdListGroup.prdList = self?.homeHotPrdList as [AnyObject]?
                prdListGroup.sectionInset = UIEdgeInsets(top: 0, left: 5, bottom: 5, right: 5)
                self?.homeMorePrd = prdListGroup
            }
            self?.requestGroup.leave()
        }.failed { [weak self] (error) in
            print("")
            self?.requestGroup.leave()
        }
    }
    
    public func requestFloorList() ->Void{
        HN.fetch(API.Home.floor, parameters: nil, headers: nil).success {[weak self] (response) in
            if let data = HT_HomeFloorData.deserialize(from: response as? Dictionary) , let array = data.data {
                self?.homeFloors?.removeAll()
                for item in array {
                    let floorGroup = HT_HomeGroup()
                    floorGroup.titleColor = item.titleColor
                    floorGroup.titleName = item.floorName
                    floorGroup.iconImge = item.floorIcon 
                    floorGroup.itemSize = CGSize(width: kScreenWidth, height: kScreenWidth / 4.5 * 1.5)
                    floorGroup.headSize = CGSize(width: kScreenWidth, height: 50)
                    floorGroup.sectionID = sectionHeaderId
                    floorGroup.cellID = floorCollectionID
                    guard let _ = item.list else {continue;}
                    floorGroup.prdList = [item]
                    floorGroup.priority = 15
                    floorGroup.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 10, right: 0)
                    
                    if floorGroup.prdList?.count ?? 0 > 0 {
//                        self?.homeGroups.append(floorGroup)
                        self?.homeFloors?.append(floorGroup)
                    }
                }
            }
            self?.requestGroup.leave()
        }.failed { [weak self] (error) in
            self?.requestGroup.leave()
        }
    }
    
    func requestMidModulesInfo() -> Void {
        HN.fetch(API.Home.midleModule, parameters: nil, headers: nil).success { [weak self] (response) in
            guard let recommandInfo = RecommendInfo.deserialize(from: response as? Dictionary) else {return}
            print("midMoulesino")
            let array = self?.paselMiddelViewData(indexInfoArray: recommandInfo.indexInfo!)
            let huiyuanGroup = array?.filter { (groupModel) -> Bool in
                if let sectionId = groupModel.sectionID{
                    return sectionId == "20"
                }
                return false
            }
            let midleBanner = array?.filter({ (groupModel) -> Bool in
                if let sectionId = groupModel.sectionID{
                    return sectionId == "5"
                }
                return false
            })
            //单独处理会员section
            self?.homeHuiyuan?.removeAll()
            if let huiyuan = huiyuanGroup?.first {
                let groupModel = self?.fretchUTehuiModel(groupModel: huiyuan)
                if let modle = groupModel {
                    self?.homeHuiyuan?.append(modle)
                }
            }
            //处理中间banner数据
            self?.requestGroup.leave()
        }.failed { (error) in
            self.requestGroup.leave()
        }
    }
    
    func paselMiddelViewData(indexInfoArray: [IndexInfoModel]) -> [HT_HomeGroup] {
        var midelsArray : Array<HT_HomeGroup> = Array()
        for indexinfo in indexInfoArray {
            let isCaninput = ModuleDatToAction.canInputData(min: indexinfo.minversion, max: indexinfo.maxversion, device: indexinfo.devicetype, version: getAppVersionStr())
            if isCaninput {
                let filter = midelsArray.filter { (obj : HT_HomeGroup) -> Bool in
                    return obj.priority == Int(indexinfo.groupsort!)
                }
                if let first = filter.first {
                    first.prdList?.append(indexinfo)
                }else {
                    let newGroup = HT_HomeGroup()
                    newGroup.priority  = Int(indexinfo.groupsort!)!
                    newGroup.sectionID = indexinfo.groupid
                    newGroup.prdList?.append(indexinfo)
                    midelsArray.append(newGroup)
                }
            }
        }
        return midelsArray
    }
    
    func fretchUTehuiModel(groupModel: HT_HomeGroup) -> HT_HomeGroup {
        var imageArray : [String] = []
        var newPrdList : [AnyObject] = []
        if let prdList = groupModel.prdList {
            if prdList.count > 1 {
                for (index, item) in prdList.enumerated() {
                    let modle = item as! IndexInfoModel
                    if let imageur = modle.imgUrl, index < 4 {
                        print(imageur)
                        imageArray.append(imageur)
                    }else{
                        modle.uTehuiIcon = imageArray[1]
                        modle.uQianGouIcon = imageArray[0]
                    }
             
                }
                let end = prdList.count
                newPrdList = Array(prdList[4 ..< end])
            }
        }
        let utehuiGourp = HT_HomeGroup()
        utehuiGourp.itemSize = CGSize(width: (kScreenWidth-1)/3.0, height: kScreenWidth/3.0 * 1.5)
        utehuiGourp.headSize = CGSize(width: kScreenWidth, height: 50)
        utehuiGourp.cellID = utehuiCellID
        utehuiGourp.sectionID = sectionHeaderId
        utehuiGourp.titleName = "邮特惠商品"
        utehuiGourp.iconImge = imageArray[1] 
        utehuiGourp.prdList = newPrdList
        utehuiGourp.priority = groupModel.priority
        return utehuiGourp
    }
    
}
