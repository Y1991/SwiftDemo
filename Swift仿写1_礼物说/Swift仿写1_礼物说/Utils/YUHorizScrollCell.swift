//
//  YUHorizScrollCell.swift
//  Swift仿写1_礼物说
//
//  Created by Guangquan Yu on 2017/9/1.
//  Copyright © 2017年 Guangquan Yu. All rights reserved.
//

import UIKit

class YUHorizScrollCell: UICollectionViewCell {
    //MARK: 1.System method
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.white
        self.makeUI()
        self.makeFrame()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
// 九宫格cell选中的方法是不存在的，下面的是表视图cell中的
//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//
//    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.titleLabel.textColor = self.isSelected ? UIColor.red : UIColor.gray;
    }
    

    
    //MARK: 2.UI
    fileprivate func makeUI() -> (){
    
            self.contentView.addSubview(self.titleLabel)
        
    }
    
    //MARK: 3.Frame
    fileprivate func makeFrame() -> (){
        
        self.titleLabel.snp.makeConstraints({ (make) in
            make.top.left.bottom.right.equalToSuperview()
        })
        
    }
    //MARK: 4.懒加载
    fileprivate lazy var titleLabel: UILabel = {
        let label = NSObject.createUILabel("", titleColor: UIColor.gray, font: UIFont.systemFont(ofSize: 13), textAlignment: .center, frame: CGRect())
        return label;
    }()

}
// MARK: - 【扩展】外界赋值
extension YUHorizScrollCell{

    //MARK: 1.赋值
    var title:NSString {  // 计算属性
        get{
            return self.titleLabel.text! as NSString;
        }set{
            self.titleLabel.text = newValue as String;
        }
    }
}
