//
//  YUHorizScrollCellTwo.swift
//  Swift仿写1_礼物说
//
//  Created by Guangquan Yu on 2017/9/3.
//  Copyright © 2017年 Guangquan Yu. All rights reserved.
//

import UIKit

class YUHorizScrollCellTwo: UICollectionViewCell {
    //MARK: 1.System method
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.purple
        self.makeUI()
        self.makeFrame()
        //self.imageView.image = UIImage.init(named: "")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //MARK: 2.UI
    fileprivate func makeUI() -> (){
        
        self.contentView.addSubview(self.imageView)
        
    }
    
    //MARK: 3.Frame
    fileprivate func makeFrame() -> (){
        
        self.imageView.snp.makeConstraints({ (make) in
            make.top.left.bottom.right.equalToSuperview().offset(1)
            
        })
        
    }
    //MARK: 4.懒加载
    fileprivate lazy var imageView: UIImageView = {
        let imgView = NSObject.createImageView("", contentMode: .scaleToFill, frame: CGRect())
        return imgView;
    }()

}

// MARK: - 【扩展】外界赋值
extension YUHorizScrollCellTwo{
    // MARK: 1.图片名
    public func imageName(_ imageName:NSString) ->(){
        self.imageView.image = UIImage(named: imageName as String)
    }
}
