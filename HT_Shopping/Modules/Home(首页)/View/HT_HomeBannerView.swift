//
//  HT_HomeBannerView.swift
//  HT_Shopping
//
//  Created by 陈竹青 on 2020/11/18.
//

import UIKit

let kHomeBannerCellID = "kHomeBannerCellID"

class HT_HomeBannerCell: UICollectionViewCell {
    lazy var mImagView : UIImageView = {
        let imagView = UIImageView()
        imagView.layer.cornerRadius = 10.0
        imagView.clipsToBounds = true
        return imagView
    }()
    
    var cellModel : BannerItem? {
        
        didSet{
            if let url = cellModel?.wapImg {
                self.mImagView.kf.setImage(with: URL(string: url))
            }
        }
    }
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        self.contentView.addSubview(self.mImagView)
        self.mImagView.snp.makeConstraints { (make) in
            make.top.bottom.equalTo(self.contentView)
            make.left.equalTo(self.contentView).offset(5)
            make.right.equalTo(self.contentView).offset(-5)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


class HT_HomeBannerView: UIView {
    
    public var mModel : HomeBanner? {
        didSet {
            self.mCollectionView.reloadData()
        }
    }
    
    lazy var mCollectionView : UICollectionView = { [unowned self] in
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0.0
//        layout.minimumInteritemSpacing = 0.0
        layout.itemSize = CGSize(width: kScreenWidth, height: self.frame.size.height-1)
        let view = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        view.dataSource = self
        view.isPagingEnabled = true
        view.register(HT_HomeBannerCell.self, forCellWithReuseIdentifier: "kHomeBannerCellID")
        view.backgroundColor = UIColor.white
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension HT_HomeBannerView {
    func loadUI() -> Void {
        self.addSubview(self.mCollectionView)
        self.mCollectionView.snp.makeConstraints { (make) in
            make.edges.equalTo(self)
        }
    }
}

extension HT_HomeBannerView: UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.mModel?.data?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kHomeBannerCellID, for: indexPath) as! HT_HomeBannerCell
        cell.cellModel = self.mModel?.data?[indexPath.row]
        return cell
    }
}
