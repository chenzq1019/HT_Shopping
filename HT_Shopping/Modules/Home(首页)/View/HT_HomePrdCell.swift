//
//  HT_HomePrdCell.swift
//  HT_Shopping
//
//  Created by 陈竹青 on 2020/11/20.
//

import UIKit
import Kingfisher

class HT_HomePrdCell: UICollectionViewCell,HTCellProtocol {
    lazy var prdImageView : UIImageView = {
        let view = UIImageView()
        return view
    }()
    var prdName : UILabel = {
        let label = UILabel()
        label.textColor = UIColor.darkGray
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    var prdPrice : UILabel = {
        let label = UILabel()
        label.textColor = UIColor.red
        label.font = UIFont.systemFont(ofSize: 13)
        return label
    }()
    
    var prdCellModel : HomeListItem?  {
        didSet{
            if let url = prdCellModel?.imgUrl {
                self.prdImageView.kf.setImage(with: URL(string: url))
            }
            self.prdName.text = prdCellModel?.listingName
            if let price = prdCellModel?.minPrice {
                self.prdPrice.text = "￥" + price
            }
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        loadUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension HT_HomePrdCell {
    func loadUI() -> Void {
        self.contentView.addSubview(self.prdImageView)
        self.contentView.addSubview(self.prdName)
        self.contentView.addSubview(self.prdPrice)
        
        self.prdImageView.snp.makeConstraints { (make) in
            make.left.top.right.equalTo(self.contentView)
            make.height.equalTo(self.prdImageView.snp.width)
        }
        self.prdName.snp.makeConstraints { (make) in
            make.left.equalTo(self.contentView).offset(5)
            make.top.equalTo(self.prdImageView.snp_bottomMargin).offset(10)
            make.right.equalTo(self.contentView).offset(-5)
            make.height.equalTo(40)
        }
        self.prdPrice.snp.makeConstraints { (make) in
            make.left.right.equalTo(self.prdName)
            make.top.equalTo(self.prdName.snp_bottomMargin).offset(5)
            make.bottom.equalTo(self.contentView).offset(-5)
        }
        
    }
}
