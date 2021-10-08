//
//  HT_HomeHuiyuanCell.swift
//  HT_Shopping
//
//  Created by 陈竹青 on 2020/11/25.
//

import UIKit

class HT_HomeHuiyuanCell: UICollectionViewCell,HTCellProtocol {
    lazy var mPrdImageView : UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    lazy var mHuiyuanLabel : UILabel = {
        let label = UILabel()
        return label
    }()
    lazy var mPrdNameLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor.darkGray
        label.numberOfLines = 0
        return label
    }()
    lazy var mPriceLabel : UILabel = {
        let label = UILabel()
        label.textColor = UIColor.red
        label.font = UIFont.systemFont(ofSize: 15)
        
        return label
    }()
    lazy var mMaxPricLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.darkGray
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()

    var cellModel: IndexInfoModel? {
        didSet{
            if let url = cellModel?.imgUrl {
                self.mPrdImageView.kf.setImage(with: URL(string: url))
            }
            if let title = cellModel?.title {
                let replace = title.replacingOccurrences(of: "&&", with: "^")
                let array = replace.split(separator: "^")
                if array.count > 3 {
                    self.mPrdNameLabel.text = String(array.last ?? "")
                    self.mPriceLabel.text = "￥" + String(array[0])
                    self.mMaxPricLabel.text = "￥" + String(array[1])
                    let str = "￥" + String(array[1])
                    print(str.count)
                    let attribute = NSMutableAttributedString(string: str)
                    attribute.addAttributes([.strikethroughStyle : 1], range:  NSRange(location: 0, length: str.count))
                    self.mMaxPricLabel.attributedText = attribute
                }
                
                
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

extension HT_HomeHuiyuanCell {
    func loadUI() -> Void {
        self.contentView.addSubview(self.mPrdImageView)
        self.contentView.addSubview(self.mHuiyuanLabel)
        self.contentView.addSubview(self.mPriceLabel)
        self.contentView.addSubview(self.mMaxPricLabel)
        self.contentView.addSubview(self.mPrdNameLabel)
        
        self.mPrdImageView.snp.makeConstraints { (make) in
            make.left.top.right.equalTo(self.contentView)
            make.height.equalTo(self.mPrdImageView.snp.width)
        }
        self.mPrdNameLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.contentView).offset(5)
            make.top.equalTo(self.mPrdImageView.snp_bottomMargin).offset(5)
            make.right.equalTo(self.contentView).offset(-5)
            make.height.equalTo(40)
        }
        self.mPriceLabel.snp.makeConstraints { (make) in
            make.left.right.equalTo(self.mPrdNameLabel)
            make.top.equalTo(self.mPrdNameLabel.snp_bottomMargin).offset(5)
            
        }
        self.mMaxPricLabel.snp.makeConstraints { (make) in
            make.left.right.equalTo(self.mPrdNameLabel)
            make.top.equalTo(self.mPriceLabel.snp_bottomMargin).offset(5)
            make.bottom.equalTo(self.contentView)
        }
    }
}
