//
//  HT_HomeViewModel.swift
//  HT_Shopping
//
//  Created by 陈竹青 on 2020/11/19.
//

import UIKit

public typealias SuccessBlock = ([AnyObject]) -> Void

class HT_HomeViewModel: NSObject {
    public var homeHotPrdList: [HomeListItem]?
    
    var requestGroup : DispatchGroup = DispatchGroup()
    var homeTopBannerModel : HomeBanner?
    var homeGroups : [HT_HomeGroup] = Array<HT_HomeGroup>()
    var success : SuccessBlock?

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
//        requestGroup.enter()
//        requestHomeBanner()
//        requestGroup.enter()
//        requestMorePrdList()
//        requestGroup.enter()
//        requestFloorList()
        requestGroup.enter()
        requestMidModulesInfo()
        requestGroup.notify(queue: DispatchQueue.main) {
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
                self?.homeGroups.append(prdListGroup)
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
                for item in array {
                    let floorGroup = HT_HomeGroup()
                    floorGroup.titleColor = item.titleColor
                    floorGroup.titleName = item.floorName as NSString?
                    floorGroup.iconImge = item.floorIcon as NSString?
                    floorGroup.itemSize = CGSize(width: kScreenWidth, height: kScreenWidth / 4.5 * 1.5)
                    floorGroup.headSize = CGSize(width: kScreenWidth, height: 50)
                    floorGroup.sectionID = sectionHeaderId
                    floorGroup.cellID = floorCollectionID
                    guard let _ = item.list else {continue;}
                    floorGroup.prdList = [item]
                    floorGroup.priority = 15
                    floorGroup.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 10, right: 0)
                    if floorGroup.prdList?.count ?? 0 > 0 {
                        self?.homeGroups.append(floorGroup)
                    }
                }
            }
            self?.requestGroup.leave()
        }.failed { [weak self] (error) in
            self?.requestGroup.leave()
        }
    }
    
    func requestMidModulesInfo() -> Void {
        HN.fetch(API.Home.midleModule, parameters: nil, headers: nil).success { (response) in
//            guard let dic = response as? Dictionary<String, Any> else { return }
//            guard let info = dic["indexInfo"] as? Array<Dictionary<String,String>> else { return }
            guard let recommandInfo = RecommendInfo.deserialize(from: response as? Dictionary) else {return}
            print("midMoulesino")
            self.requestGroup.leave()
        }.failed { (error) in
            self.requestGroup.leave()
        }
    }
}
