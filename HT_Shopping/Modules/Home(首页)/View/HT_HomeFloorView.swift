//
//  HT_HomeFloorView.swift
//  HT_Shopping
//
//  Created by 陈竹青 on 2020/11/18.
//

import UIKit

let floorCellID : String = "FloorCellID"

class HT_HomeFloorCell: UICollectionViewCell {
    var mPrdImageView : UIImageView = UIImageView()
    lazy var mPriceLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = UIColor.red
        return label
    }()
    lazy var mPrdNameLabel : UILabel = {
        let label =  UILabel()
        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor =  UIColor.darkGray
        return label
    }()
    
    var mFloorModel : HT_FloorPrd? {
        didSet{
            if let url = mFloorModel?.imgUrl {
                self.mPrdImageView.kf.setImage(with: URL(string: url))
            }
            if let price = mFloorModel?.customPrice {
                self.mPriceLabel.text = "￥" + price
            }            
            self.mPrdNameLabel.text = mFloorModel?.title
            
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentView.addSubview(self.mPrdImageView)
        self.contentView.addSubview(self.mPriceLabel)
        self.contentView.addSubview(self.mPrdNameLabel)
        
        self.mPrdImageView.snp.makeConstraints { (make) in
            make.left.top.right.equalTo(self.contentView)
            make.height.equalTo(self.mPrdImageView.snp.width)
        }
        self.mPriceLabel.snp.makeConstraints { (make) in
            make.left.right.equalTo(self.contentView)
            make.top.equalTo(self.mPrdImageView.snp_bottomMargin).offset(5)
        }
        self.mPrdNameLabel.snp.makeConstraints { (make) in
            make.left.right.equalTo(self.contentView)
            make.top.equalTo(self.mPriceLabel.snp_bottomMargin).offset(5)
            make.bottom.equalTo(self.contentView)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


class HT_HomeFloorView: UICollectionViewCell,HTCellProtocol {
    
    var floorItems : [HT_FloorPrd]? {
        didSet {
            self.mCollectionView.reloadData()
        }
    }
    lazy var mCollectionView : UICollectionView = { [unowned self] in
        let layout =  UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let width = kScreenWidth / 4.5
        let height = width * 1.5
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        layout.itemSize = CGSize(width: width, height: height-1)
        let collection = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collection.register(HT_HomeFloorCell.self, forCellWithReuseIdentifier: floorCellID)
        collection.backgroundColor = UIColor.white
        collection.dataSource = self
        return collection
    }()
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        loadUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension HT_HomeFloorView {
    func loadUI() -> Void {
        self.addSubview(self.mCollectionView)
        
        self.mCollectionView.snp.makeConstraints { (make) in
            make.edges.equalTo(self)
        }
    }
}

extension HT_HomeFloorView: UICollectionViewDataSource,UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.floorItems?.count ?? 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: floorCellID, for: indexPath) as! HT_HomeFloorCell
        cell.backgroundColor = UIColor.white
        cell.mFloorModel = self.floorItems?[indexPath.row]
        return cell
    }
}
