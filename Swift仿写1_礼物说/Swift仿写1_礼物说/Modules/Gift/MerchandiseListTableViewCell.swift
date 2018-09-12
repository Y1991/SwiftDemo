//
//  MerchandiseListTableViewCell.swift
//  Swift仿写1_礼物说
//
//  Created by Guangquan Yu on 2017/9/3.
//  Copyright © 2017年 Guangquan Yu. All rights reserved.
//

import UIKit

// MARK: - 【类】
class MerchandiseListTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

     
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
    }
    
    //MARK: 1.System method
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.backgroundColor = UIColor.green
        self.makeUI()
        self.makeFrame()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
 
    
    
    
    
    //MARK: 2.UI
    fileprivate func makeUI() -> (){
        
        self.contentView.addSubviews([self.topView, self.middleImgView, self.bottomView])
        //------------------
        
        self.topView.addSubviews([self.tagLabel, self.storeLabel, self.shopOwnerLabel, self.headImgView])
        //------------------
        
        self.bottomView.addSubviews([self.titleLabel, self.loveButton])
        //------------------
    }
    //MARK: 3.Frame
    fileprivate func makeFrame() -> (){
        self.makeFrameForModule()
        self.makeFrameForModule_topView()
        self.makeFrameForModule_bottomView()
    }
    

    //MARK: 4.懒加载
    //一级UIView
    fileprivate lazy var topView: UIView = {
        let view = NSObject.createView(UIColor.white, frame: CGRect())
        return view;
    }()
    fileprivate lazy var middleImgView: UIImageView = {
        let imgView = NSObject.createImageView("", contentMode: .scaleToFill, frame: CGRect())
        return imgView;
    }()
    fileprivate lazy var bottomView: UIView = {
        let view = NSObject.createView(UIColor.white, frame: CGRect())
        return view;
    }()
    
    //---------------
    //二级UIView （1）
    fileprivate lazy var tagLabel: UILabel = {
        let label = NSObject.createUILabel("", titleColor: UIColor.init(red: 240/255.0, green: 224/255.0, blue: 224/255.0, alpha: 1), font: UIFont.systemFont(ofSize: 13), textAlignment: .center, frame: CGRect())
        label.backgroundColor = UIColor.red
        return label;
    }()
    
    fileprivate lazy var storeLabel: UILabel = {
        let label = NSObject.createUILabel("", titleColor: UIColor.gray, font: UIFont.systemFont(ofSize: 13), textAlignment: .center, frame: CGRect())
        return label;
    }()
    
    fileprivate lazy var shopOwnerLabel: UILabel = {
        let label = NSObject.createUILabel("", titleColor: UIColor.gray, font: UIFont.systemFont(ofSize: 13), textAlignment: .center, frame: CGRect())
        return label;
    }()
    
    fileprivate lazy var headImgView: UIImageView = {
        let imgView = NSObject.createImageView("", contentMode: .scaleToFill, frame: CGRect())
        return imgView;
    }()
    //------------------
    //二级UIView （2）
    fileprivate lazy var titleLabel: UILabel = {
        let label = NSObject.createUILabel("", titleColor: UIColor.black, font: UIFont.systemFont(ofSize: 15), textAlignment: .center, frame: CGRect())
        return label;
    }()
    
    fileprivate lazy var loveButton: UIButton = {
        let button = NSObject.createButton("23076", titleColor: UIColor.lightGray, imageName: "feed_favoriteicon", frame: CGRect(), target: self, action: #selector(MerchandiseListTableViewCell.loveAction))
        button.titleLabel?.font = UIFont.systemFont(ofSize: 10)
        button.setImage(UIImage.init(named: "feed_favoriteicon_selected"), for: .selected)
        return button;
    }()

    //MARK: 5.声明引用
    weak open var delegate: MerchandiseListTableViewCellDelegate?
    //MARK: 6.存储属性
    fileprivate var dataDic:NSDictionary?

   
}


// MARK: - 【扩展】Frame
extension MerchandiseListTableViewCell{
    //MARK: 1.Frame 模块
    fileprivate func makeFrameForModule() -> (){
        
        self.topView.snp.makeConstraints({ (make) in
            make.top.equalToSuperview().offset(2.5)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.height.equalTo(50)
        })
        
        self.middleImgView.snp.makeConstraints({ (make) in
            make.top.equalTo(self.topView.snp.bottom)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.height.equalTo(160)
        })
        
        self.bottomView.snp.makeConstraints({ (make) in
            make.top.equalTo(self.middleImgView.snp.bottom)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.height.equalTo(55)
        })

    }
    
    //MARK: 1-1.Frame topView模块
    fileprivate func makeFrameForModule_topView() -> (){
        self.tagLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(8)
            make.centerY.equalToSuperview()
            make.width.equalTo(40)
            make.height.equalTo(20)
        }
        self.tagLabel.radiusBorder(5, borderColor: UIColor.white, borderWidth: 0)
        
        
        self.storeLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.tagLabel.snp.right).offset(5)
            make.centerY.equalToSuperview()
            make.width.equalTo(100)
            make.height.equalTo(20)
        }
        
        self.shopOwnerLabel.snp.makeConstraints { (make) in
            make.trailing.equalToSuperview().offset(-8)
            make.centerY.equalToSuperview()
            make.width.equalTo(100)
            make.height.equalTo(20)
        }
        
        self.headImgView.snp.makeConstraints { (make) in
            make.right.equalTo(self.shopOwnerLabel.snp.left).offset(-5)
            make.centerY.equalToSuperview()
            make.width.equalTo(30)
            make.height.equalTo(30)
        }
        self.headImgView.radiusBorder(15, borderColor: UIColor.white, borderWidth: 0)
    }

    
    //MARK: 1-3.Frame bottomView模块
    fileprivate func makeFrameForModule_bottomView() -> (){
        self.titleLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(5)
            make.centerY.equalToSuperview()
            make.width.equalTo(200)
            make.height.equalTo(30)
        }
        self.loveButton.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-8)
            make.centerY.equalToSuperview()
            make.width.equalTo(50)
            make.height.equalToSuperview()
        }
    }
}
// MARK: - 【扩展】点击事件
extension MerchandiseListTableViewCell{
    @objc fileprivate func loveAction(_ button:UIButton?) ->(){
        button?.isSelected = !(button?.isSelected)!
        
        //调用代理
        if ((self.delegate) != nil)&&(self.delegate?.responds(to: Selector(("merchandiseListTableViewCell:didSelect:"))))! {
            self.delegate?.merchandiseListTableViewCell(self, didSelect: "收藏")
        }
    }
    
}
// MARK: - 【扩展】外界赋值
extension MerchandiseListTableViewCell{
    func value(dictionary: NSDictionary) -> () {
    
        self.dataDic = dictionary
        
        self.middleImgView.image = UIImage(named: dictionary["midImageName"] as! String)
        
        //------------------
        self.tagLabel.text = dictionary["tag"] as? String
        
        self.storeLabel.text = dictionary["store"] as? String
        
        self.shopOwnerLabel.text = dictionary["shopOwner"] as? String
        
        self.headImgView.image = UIImage(named: dictionary["headImg"] as! String)
        //-----------------
        self.titleLabel.text = dictionary["title"] as? String
        self.loveButton.setTitle(dictionary["love"] as? String, for: .normal)
        
        
        self.shopOwnerLabel.snp.updateConstraints { (make) in
            make.width.equalTo(NSObject.sizeWithText(text: dictionary["shopOwner"] as! NSString, font: self.shopOwnerLabel.font, size: CGSize.init(width: UIScreen.main.bounds.size.width, height: 20)).width+3)
        }
        
        self.titleLabel.snp.updateConstraints { (make) in
            make.width.equalTo(NSObject.sizeWithText(text: dictionary["title"] as! NSString, font: self.titleLabel.font, size: CGSize.init(width: UIScreen.main.bounds.size.width, height: 20)).width+3)
        }
        
        self.loveButton.snp.updateConstraints { (make) in
            make.width.equalTo(NSObject.sizeWithText(text: dictionary["love"] as! NSString, font: (self.loveButton.titleLabel?.font)!, size: CGSize.init(width: UIScreen.main.bounds.size.width, height: 20)).width+20)
        }
        
        
    }


}
// MARK: - 【声明】协议 MerchandiseListTableViewCellDelegate
protocol MerchandiseListTableViewCellDelegate: NSObjectProtocol {
    func merchandiseListTableViewCell(_ cell: MerchandiseListTableViewCell, didSelect string: NSString) -> ()
}


