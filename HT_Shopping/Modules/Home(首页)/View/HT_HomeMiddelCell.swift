//
//  HT_HomeMiddelCell.swift
//  HT_Shopping
//
//  Created by 陈竹青 on 2021/9/2.
//
/**
 中间模块，包括多个可左右滑动的模块，每个模块分三个部分。左边，右边上，右边下
|       |
|       |  右上
|  左边  |________
|       |
|       |  右下
|_______|_________
 */
import UIKit

@objc protocol HTCellProtocol {
    @objc optional func setModel(data: Any) -> Void
}

class HT_ItemView: UIView {
    var itemData: IndexInfoModel?
    lazy var imageView : UIImageView = {
        let imageView =  UIImageView()
        return imageView
    }()
    lazy var titleLabel : UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 14)
        label.text = "这是一个商品名称描述的文案"
        label.numberOfLines = 0
        return label
    }()
    lazy var priceLabel : UILabel = {
        let label = UILabel()
        label.textColor = .red
        label.font = UIFont.systemFont(ofSize: 16)
        label.text = "￥19.0"
        return label
    }()
    lazy var olderPriceLabelb : UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 15)
        label.text = "￥19.0"
        return label
    }()
    lazy var flagLabel : UILabel = {
        let flagLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 80, height: 20))
        flagLabel.backgroundColor = UIColor.randomColor
        flagLabel.text = "运动户外"
        flagLabel.textColor = .white
        flagLabel.textAlignment = .center
        flagLabel.font = UIFont.systemFont(ofSize: 14)
        let layer : CAShapeLayer = CAShapeLayer()
        layer.frame = flagLabel.bounds
        let path : UIBezierPath = UIBezierPath(roundedRect: flagLabel.bounds, byRoundingCorners: .bottomRight, cornerRadii: CGSize(width: 20, height: 20))
        layer.path = path.cgPath
        flagLabel.layer.mask = layer
        return flagLabel
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.loadUI(type:"")
    }
    
    init(type:String) {
        super.init(frame: CGRect.zero)
        self.loadUI(type: type)
        self.backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func loadUI(type: String) -> Void {
        self.addSubview(self.flagLabel)
        self.addSubview(self.titleLabel)
        self.addSubview(self.priceLabel)
        self.addSubview(self.olderPriceLabelb)
        self.addSubview(self.imageView)
        if type == "left" {
            self.flagLabel.snp.makeConstraints { (make) in
                make.left.top.equalTo(self)
                make.width.equalTo(80)
                make.height.equalTo(20)
            }
            self.titleLabel.snp.makeConstraints { (make) in
                make.left.equalTo(self).offset(10)
                make.right.equalTo(self).offset(-10)
                make.top.equalTo(self.flagLabel.snp.bottom).offset(10)
            }
            self.priceLabel.snp.makeConstraints { (make) in
                make.left.equalTo(self).offset(10)
                make.right.equalTo(self).offset(-10)
                make.top.equalTo(self.titleLabel.snp.bottom).offset(10)
            }
            self.olderPriceLabelb.snp.makeConstraints { (make) in
                make.left.equalTo(self).offset(10)
                make.right.equalTo(self).offset(-10)
                make.top.equalTo(self.priceLabel.snp.bottom).offset(5)
            }
            self.imageView.snp.makeConstraints { (make) in
                make.left.right.bottom.equalTo(self)
                make.height.equalTo(self).multipliedBy(0.5)
            }
            
        } else {
            self.flagLabel.snp.makeConstraints { (make) in
                make.left.top.equalTo(self)
                make.width.equalTo(80)
                make.height.equalTo(20)
            }
            self.imageView.snp.makeConstraints { (make) in
                make.top.right.bottom.equalTo(self)
                make.width.equalTo(self.imageView.snp.height)
            }
            self.titleLabel.snp.makeConstraints { (make) in
                make.left.equalTo(self).offset(10)
                make.top.equalTo(self.flagLabel.snp.bottom).offset(10)
                make.right.equalTo(self.imageView.snp.left)
            }
            self.priceLabel.snp.makeConstraints { (make) in
                make.left.equalTo(self).offset(10)
                make.top.equalTo(self.titleLabel.snp.bottom).offset(10)
                make.right.equalTo(self.imageView.snp.left)
            }
            self.olderPriceLabelb.snp.makeConstraints { (make) in
                make.left.equalTo(self).offset(10)
                make.top.equalTo(self.priceLabel.snp.bottom)
                make.right.equalTo(self.imageView.snp.left)
            }
            
        }
        
    }
    
    func loadData(data: IndexInfoModel) -> Void {
        self.itemData = data
        self.titleLabel.text = data.title
        
        
        if let array =  data.title?.components(separatedBy: "&&") {
//            let array = titleStr.split(separator: "&").map(String.init)
            self.flagLabel.text = array[0]
            self.titleLabel.text = array[1]
            let priceStr = "￥" + array[2]
            let attributeStr = NSMutableAttributedString(string: priceStr)
            attributeStr.addAttributes([NSAttributedString.Key.font : UIFont.systemFont(ofSize: 13)], range: NSRange(location: 0,length: 1))
//            self.priceLabel.text = "￥" + array[2]
            self.priceLabel.attributedText = attributeStr
            let olderPriceStr : String = "￥" + array[3]
            let attributeOldPrice = NSMutableAttributedString(string: olderPriceStr)
            attributeOldPrice.addAttributes([NSAttributedString.Key.font : UIFont.systemFont(ofSize: 13)], range: NSRange(location: 0, length: 1))
            attributeOldPrice.addAttributes([NSAttributedString.Key.strikethroughStyle : NSUnderlineStyle.single.rawValue], range: NSRange(location: 0, length: attributeOldPrice.length))
            self.olderPriceLabelb.attributedText = attributeOldPrice
        }
        self.imageView.kf.setImage(with: URL(string: data.imgUrl!))
        self.flagLabel.backgroundColor = UIColor(rgb: data.change_attri!)
        
    }
}

class HT_HomeMidelItemCell: UICollectionViewCell,HTCellProtocol {
    
    lazy var leftView : HT_ItemView = {
        let view = HT_ItemView(type: "left")
        return view
    }()
    lazy var rightTopView : HT_ItemView = {
        let view = HT_ItemView(type: "right")
        return view
    }()
    lazy var rightBottomView : HT_ItemView = {
        let view = HT_ItemView(type: "right")
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(self.leftView)
        self.addSubview(self.rightTopView)
        self.addSubview(self.rightBottomView)
        
        self.leftView.snp.makeConstraints { (make) in
            make.left.top.bottom.equalTo(self)
            make.width.equalTo(frame.size.width*0.38)
        }
        self.rightTopView.snp.makeConstraints { (make) in
            make.left.equalTo(self.leftView.snp.right)
            make.top.equalTo(self)
            make.right.equalTo(self)
            make.height.equalTo(frame.height/2.0)
        }
        self.rightBottomView.snp.makeConstraints { (make) in
            make.top.equalTo(self.rightTopView.snp.bottom)
            make.left.equalTo(self.leftView.snp.right)
            make.right.equalTo(self)
            make.bottom.equalTo(self)
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func loadUI() -> Void {
        
    }
    
    func setModel(data: Any) {
        let array : [IndexInfoModel] = data as! [IndexInfoModel]
        let leftIndexModel : IndexInfoModel = array.first!
        self.leftView.loadData(data: leftIndexModel)
        let rightIndexModel : IndexInfoModel = array[1]
        self.rightTopView.loadData(data: rightIndexModel)
        let rightBottmModel : IndexInfoModel = array[2]
        self.rightBottomView.loadData(data: rightBottmModel)
    }
}


class HT_HomeMiddelCell: UICollectionViewCell {
    var middelDataArray : [[IndexInfoModel]] = []
    
    lazy var mCollectionView : UICollectionView = { [unowned self] in
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0.0
        layout.minimumInteritemSpacing = 0.0
        let view = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        view.delegate = self
        view.dataSource = self
        view.isPagingEnabled = true
        view.backgroundColor = .white
        view.register(HT_HomeMidelItemCell.self, forCellWithReuseIdentifier: "HT_HomeMidelItemCell")
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentView.addSubview(self.mCollectionView)
        self.mCollectionView.snp.makeConstraints { (make) in
            make.edges.equalTo(self.contentView)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension HT_HomeMiddelCell:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.middelDataArray.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell : HT_HomeMidelItemCell = collectionView.dequeueReusableCell(withReuseIdentifier: "HT_HomeMidelItemCell", for: indexPath) as! HT_HomeMidelItemCell
        cell.setModel(data: self.middelDataArray[indexPath.row])
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        return self.frame.size
    }
}

extension HT_HomeMiddelCell:HTCellProtocol {
     func setModel(data: Any) {
        
        let dataArray = data as! [IndexInfoModel]
        self.middelDataArray = stride(from: 0, to: dataArray.count, by: 3).map {
            Array(dataArray[$0...$0+2])
        }
        self.mCollectionView.reloadData()
    }
}
