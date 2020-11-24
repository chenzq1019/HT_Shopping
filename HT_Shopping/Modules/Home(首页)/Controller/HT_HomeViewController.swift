//
//  HT_HomeViewController.swift
//  HT_Shopping
//
//  Created by 陈竹青 on 2020/11/18.
//

import UIKit

let cellW: CGFloat = (kScreenWidth - 15)/2.0
let cellH: CGFloat = screenScale(width: 500)
let cellId : String  = "homeCellId"
let sectionHeaderId : String = "sectionHeaderId"
let floorCollectionID : String = "floorCollectionID"

class HT_HomeViewController: HT_BaseViewController {
    lazy var mViewModel : HT_HomeViewModel = {
        let vm = HT_HomeViewModel()
        return vm
    }()
    lazy var mHomeTopBanner : HT_HomeBannerView = {
        let height =  kScreenWidth * (1 / 2.5)
        let banner = HT_HomeBannerView(frame: CGRect(x: 0, y: -height, width: kScreenWidth, height: height))
        return banner
    }()
    var layout : UICollectionViewFlowLayout?
    
    lazy var mCollection : UICollectionView = { [unowned self] in
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 5
        layout.minimumInteritemSpacing = 5
        layout.sectionInset = UIEdgeInsets(top: 0, left: 5, bottom: 5, right: 5)
        layout.itemSize = CGSize(width: cellW, height: cellH)
        self.layout = layout
        let collection = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collection.dataSource = self
        collection.delegate = self
        collection.register(HT_HomePrdCell.self, forCellWithReuseIdentifier: cellId)
        collection.backgroundColor = UIColor(rgb: "#e0e0e0")
        collection.register(HT_HomeSectionHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: sectionHeaderId)
        collection.register(HT_HomeFloorView.self, forCellWithReuseIdentifier: floorCollectionID)
        collection.contentInset = UIEdgeInsets(top: kScreenWidth * (1 / 2.5), left: 0, bottom: 0, right: 0)
        return collection
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor =  UIColor.white
        mViewModel.requestAllData {[weak self] in
            self?.mCollection.reloadData()
            self?.mHomeTopBanner.mModel = self?.mViewModel.homeTopBannerModel
        }
        loadUI()
    }
}

extension HT_HomeViewController {
    func loadUI() -> Void {
        self.view.addSubview(self.mCollection)
        self.mCollection.snp.makeConstraints { (make) in
            make.edges.equalTo(self.view)
        }
        self.mCollection.addSubview(self.mHomeTopBanner)
    }
}

extension HT_HomeViewController: UICollectionViewDataSource, UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return self.mViewModel.homeGroups.count
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let group = self.mViewModel.homeGroups[section]
        return group.prdList?.count ?? 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let group = self.mViewModel.homeGroups[indexPath.section]
        let prdItem = group.prdList?[indexPath.row]
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: group.cellID!, for: indexPath)
        cell.backgroundColor = UIColor.white
        switch prdItem {
            case let item as HomeListItem:
                let  cell1 = cell as! HT_HomePrdCell
                cell1.prdCellModel = item
            case let item as HT_FloorItem:
                let cell2 = cell as! HT_HomeFloorView
                cell2.floorItems = item.list
            default:
                print("===")
        }
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: sectionHeaderId, for: indexPath) as! HT_HomeSectionHeader
        let group = self.mViewModel.homeGroups[indexPath.section]
        header.sectionModel = group
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let group = self.mViewModel.homeGroups[indexPath.section]
        return group.itemSize!
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        let group = self.mViewModel.homeGroups[section]
        return group.headSize!
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let group = self.mViewModel.homeGroups[section]
        return group.sectionInset!
    }
}
