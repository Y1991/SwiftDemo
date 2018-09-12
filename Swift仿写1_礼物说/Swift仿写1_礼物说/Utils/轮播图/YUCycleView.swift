//
//  YUCycleView.swift
//  Swift仿写1_礼物说
//
//  Created by Guangquan Yu on 2017/9/24.
//  Copyright © 2017年 Guangquan Yu. All rights reserved.
//

import UIKit
import AlamofireImage
import Alamofire
class YUCycleView: UIView {

    //MARK: 1.System method
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.makeUI()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //MARK: 2.UI
    fileprivate func makeUI() {
        self.addSubviews([self.mainImageView])
//        self.mainImageView.backgroundColor = NSObject.randomColor()

    }
    //MARK: 3.Frame
    fileprivate func makeFrame(_ model:YUCycleModel) {

        self.mainImageView.frame = CGRect(x: 0, y: 0, width: CGFloat(model.getWidth), height: CGFloat(model.getHeight))


    }

    //MARK: 3.存储属性
    var model: YUCycleModel?



    //MARK: 4.声明引用
    weak open var delegate: YUHorizScrollViewDelegate?


    //MARK: 5.懒加载
    // 懒加载 （1）mainImageView
    fileprivate lazy var mainImageView:UIImageView = {

        let imageView = NSObject.createImageView(nil, contentMode: .scaleAspectFill, frame: CGRect.init());
        return imageView
    }()


}
// MARK: - 【扩展】外界赋值
extension YUCycleView{
    func value(model: YUCycleModel?) -> () {
        self.model = model
        
        self.makeFrame(model!)

        self.mainImageView.af_setImage(withURL: URL(string: (model?.networkImageName)!)!, placeholderImage: UIImage(named: (model?.placeholderImageName)!))

        
    }
}

