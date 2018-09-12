//
//  MerchandiseListTableHeaderView.swift
//  Swift仿写1_礼物说
//
//  Created by Guangquan Yu on 2017/9/4.
//  Copyright © 2017年 Guangquan Yu. All rights reserved.
//

import UIKit

class MerchandiseListTableHeaderView: UIView {

    //MARK: system method
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.makeUI()
        self.makeFrame()

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: 创建UI
    fileprivate func makeUI() ->(){

        self.addSubviews([self.cycleScrollView, self.horizScrollView])

    }
    
    //MARK: 设置Frame
    fileprivate func makeFrame() ->(){
//        self.cycleScrollView.snp.makeConstraints { (make) in
//            make.top.equalTo(self.snp.top)
//            make.left.equalTo(self.snp.left)
//            make.width.equalTo(self.snp.width)
//            make.height.equalTo(200)
//        }
        self.horizScrollView.snp.makeConstraints { (make) in
//            make.top.equalTo(self.cycleScrollView.snp.bottom)
            make.top.equalTo(200)
            make.left.right.equalTo(self)
            make.bottom.equalToSuperview()
           
        }
    }
    
    //MARK: 懒加载
    fileprivate lazy var horizScrollView: YUHorizScrollViewTwo = {
        let horizScrollView = YUHorizScrollViewTwo.init(frame: CGRect(x: 0, y: 0, width: 0, height: 100))
        return horizScrollView;
    }()
    
//    fileprivate lazy var imageView: UIImageView = {
//        let imgView = NSObject.createImageView("", contentMode: .scaleToFill, frame: CGRect())
//        return imgView;
//    }()
        fileprivate lazy var cycleScrollView: YUCycleScrollView = {
            let arr:Array = ["https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1505210821835&di=d943fd035aeb35aa998fd92b4490c1e3&imgtype=0&src=http%3A%2F%2Fpic.58pic.com%2F58pic%2F15%2F67%2F06%2F18x58PICSdN_1024.jpg",
            "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1505210930030&di=9fd95a06462b38e8a1120594d8eb2d96&imgtype=0&src=http%3A%2F%2Fpic30.photophoto.cn%2F20140306%2F0008020239049288_b.jpg",
            "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1505210930032&di=04a30e4f19af66406624ad57dbffd365&imgtype=0&src=http%3A%2F%2Fpic24.photophoto.cn%2F20120831%2F0008020276216197_b.jpg",
            "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1505210930029&di=f32a6ee275f7673f206a96da3671afde&imgtype=0&src=http%3A%2F%2Fpic40.nipic.com%2F20140406%2F2531170_213111075000_2.jpg",
            "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1505210930063&di=06e52995912d571dcd11df1b6a489313&imgtype=0&src=http%3A%2F%2Fpic.58pic.com%2F58pic%2F15%2F68%2F56%2F05Z58PICtIN_1024.jpg"]
            var muArr: NSMutableArray = NSMutableArray()
            for i in 0..<arr.count {
                let model: YUCycleModel = YUCycleModel()
                
                model.networkImageName = arr[i];
                model.placeholderImageName = String(format: "%d.jpg",i+1)
                model.index  = i;
                muArr.add(model)
            }
      
           
            let scrollView: YUCycleScrollView = YUCycleScrollView.create(CGRect(x: 0, y: 0, width:UIScreen.main.bounds.size.width, height: 200), data: Array(muArr) as! [YUCycleModel] )//?[YUCycleModel]
            
           
//            self.snp.makeConstraints { (make) in
//                make.width.de
//            }
//            self.snp.prepareConstraints(<#T##closure: (ConstraintMaker) -> Void##(ConstraintMaker) -> Void#>)
//            makeConstraints(<#T##closure: (ConstraintMaker) -> Void##(ConstraintMaker) -> Void#>)
//            self.makeExtendableWithAttributes(.left)
//            NSLog("------------------%f" , self.snp.width.description.constant)
//            self.addSubview(scrollView)
            
            return scrollView;
        }()
    
    //MARK: 存储属性
    //public var typeString:String?
    var typeString: String? = "" {
        willSet {
            if newValue != "精选" {
                self.cycleScrollView.isHidden = true
                self.horizScrollView.isHidden = true
                self.frame = CGRect()
                self.isHidden = true
            }
            
        }
        
        didSet {
            
        }
    }
    //MARK: 赋值
    public func data(_ data:NSDictionary) ->(){
        
//        self.imageView.image = UIImage(named: data["loopImage"] as! String)
//        self.cycleScrollView
        self.horizScrollView.data = (data["horizScroll"] as? NSArray)!
    }

}
