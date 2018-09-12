//
//  YUHorizScrollViewTwo.swift
//  Swift仿写1_礼物说
//
//  Created by Guangquan Yu on 2017/9/3.
//  Copyright © 2017年 Guangquan Yu. All rights reserved.
//

import UIKit

//MARK: - 【类】
class YUHorizScrollViewTwo: UIView {

    //MARK: 1.System method
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.makeUI()
        self.makeFrame()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: 2.UI
    fileprivate func makeUI() {
        self.addSubview(self.collectionView)
    }
    
    //MARK: 3.Frame
    fileprivate func makeFrame() {
        self.collectionView.snp.makeConstraints { (make) in
            make.top.left.bottom.right.equalToSuperview()
        }
        
    }
    

    //MARK: 4.存储属性
    fileprivate var dataArray:NSArray = []
    fileprivate var seletedIndex:NSInteger = 0
    
    //MARK: 5.声明引用
    weak open var delegate: YUHorizScrollViewTwoDelegate?
    //------------------------------------------------------------------}
    
    //MARK: 6.懒加载
    // (1) 流式布局
    fileprivate lazy var flowLayout:UICollectionViewFlowLayout = {
        let flowLayout = UICollectionViewFlowLayout()
        
        flowLayout.itemSize = CGSize(width: UIScreen.main.bounds.size.width/3.0, height: self.frame.size.height)
        
        flowLayout.minimumLineSpacing      = 0;
        flowLayout.minimumInteritemSpacing = 0;
        flowLayout.scrollDirection  = .horizontal
        return flowLayout
    }()
    // (2) 九宫格
    fileprivate lazy var collectionView:UICollectionView = {
        let collectionView = UICollectionView(frame: self.bounds, collectionViewLayout: self.flowLayout)
        
        collectionView.delegate                       = self as UICollectionViewDelegate;
        collectionView.dataSource                     = self as UICollectionViewDataSource;
        collectionView.isScrollEnabled                  = true;
        collectionView.showsHorizontalScrollIndicator = false;
        collectionView.backgroundColor                = UIColor.lightGray
        collectionView.alwaysBounceHorizontal         = true;
        
        let cellClassName: String = "YUHorizScrollCellTwo"
        let cellIdentifier: String = "YUHorizScrollCellTwo"
        collectionView.register(NSClassFromString(NSObject.targetName+"."+(cellClassName as String)) as AnyClass?, forCellWithReuseIdentifier: cellIdentifier)
        
        return collectionView
    }()

}


// MARK: - 【扩展】外界赋值
extension YUHorizScrollViewTwo{
    
    //MARK: 1.数据源（计算属性）
    public var data:NSArray {
        get{
            return self.dataArray
        }set{
            self.dataArray = newValue;
            
            self.collectionView.reloadData()
            
        }
        
    }
    
}
// MARK: - 【声明】协议 YUHorizScrollViewTwoDelegate
protocol YUHorizScrollViewTwoDelegate: NSObjectProtocol {
    func horizScrollViewTwo(_ view: YUHorizScrollViewTwo, didSelect index: Int) -> ()
}

// MARK: - 【扩展】实现协议 UICollectionViewDelegate
extension YUHorizScrollViewTwo: UICollectionViewDelegate {
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if self.delegate==nil&&(self.collectionView == collectionView) {
            
        }
        //调用代理
        if ((self.delegate) != nil)&&(self.delegate?.responds(to: Selector(("horizScrollViewTwo:didSelect:"))))! {
            self.delegate?.horizScrollViewTwo( self, didSelect: indexPath.row)
        }
        
        
        
    }
}
// MARK: - 【扩展】实现协议 UICollectionViewDataSource
extension YUHorizScrollViewTwo: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.dataArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // 复用cell
        let cell:YUHorizScrollCellTwo = collectionView.dequeueReusableCell(withReuseIdentifier: "YUHorizScrollCellTwo", for: indexPath) as! YUHorizScrollCellTwo
        
        cell.imageName(self.dataArray[indexPath.row] as! NSString)
        
        return cell;
    }
}
