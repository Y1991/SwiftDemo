//
//  YUHorizScrollView.swift
//  Swift仿写1_礼物说
//
//  Created by Guangquan Yu on 2017/9/1.
//  Copyright © 2017年 Guangquan Yu. All rights reserved.
//

import UIKit

class YUHorizScrollView: UIView {
    
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
        self.collectionView.addSubview(self.arrowImageView)
    
    }
    //MARK: 3.Frame
    fileprivate func makeFrame() {
        self.collectionView.snp.makeConstraints { (make) in
            make.top.left.bottom.right.equalToSuperview()
        }
        
        self.arrowImageView.frame = CGRect(x: (UIScreen.main.bounds.size.width / 5.0 - 13) * 0.5, y: self.frame.size.height - 7, width: 13, height: 7);
    }
    
    //MARK: 3.存储属性
    fileprivate var dataArray:NSArray = []
    fileprivate var seletedIndex:NSInteger = 0

    
    
    //MARK: 4.声明引用
    weak open var delegate: YUHorizScrollViewDelegate?
   
    
    //MARK: 5.懒加载
    // 懒加载 （1）flowLayout
    fileprivate lazy var flowLayout:UICollectionViewFlowLayout = {
        let flowLayout = UICollectionViewFlowLayout()
     
        flowLayout.itemSize = CGSize(width: UIScreen.main.bounds.size.width/5.0, height: self.frame.size.height)
        
        flowLayout.minimumLineSpacing      = 0;
        flowLayout.minimumInteritemSpacing = 0;
        flowLayout.scrollDirection  = .horizontal
        return flowLayout
    }()
    // 懒加载 （2）collectionView
    fileprivate lazy var collectionView:UICollectionView = {
        let collectionView = UICollectionView(frame: self.bounds, collectionViewLayout: self.flowLayout)
        
        collectionView.delegate                       = self as UICollectionViewDelegate;
        collectionView.dataSource                     = self as UICollectionViewDataSource;
        collectionView.isScrollEnabled                  = true;
        collectionView.showsHorizontalScrollIndicator = false;
        collectionView.backgroundColor                = UIColor.lightGray
        collectionView.alwaysBounceHorizontal         = true;
        
        let cellClassName: String = "YUHorizScrollCell"
        let cellIdentifier: String = "YUHorizScrollCell"
        collectionView.register(NSClassFromString(NSObject.targetName+"."+(cellClassName as String)) as AnyClass?, forCellWithReuseIdentifier: cellIdentifier)
        
        return collectionView
    }()
    // 懒加载 （3）底部箭头
    fileprivate lazy var arrowImageView:UIImageView = {
        let imageView = NSObject.createImageView("horizscroll_arrow", contentMode: .scaleAspectFit, frame: CGRect(x: (UIScreen.main.bounds.size.width / 5.0 - 13) * 0.5, y: self.frame.size.height - 7, width: 13, height: 7))
        imageView.backgroundColor = UIColor.red
        return imageView
    }()
    
    
}

// MARK: - 【扩展】私有方法
extension YUHorizScrollView{
    
    /// 改变底部箭头Frame
    ///
    /// - Parameter index: 控制移动位置
    func animate(index:NSInteger) -> () {
        // 无主引用 【block循环】
        unowned let weakSelf:YUHorizScrollView = self;
        
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut, animations: {
            weakSelf.arrowImageView.centerX = CGFloat(index) * UIScreen.main.bounds.size.width / 5.0 + UIScreen.main.bounds.size.width / 10.0;
        }) { (finished) in
            // 这个应该是完成动作时调用吧，未测
        }
    }
   
}

// MARK: - 【扩展】外界赋值
extension YUHorizScrollView{

    // MARK: 1.数据源（计算属性）
    public var data:NSArray {
        get{
            return self.dataArray
        }set{
            self.dataArray = newValue;
            
            self.collectionView.reloadData()
            
            //默认第一项选中
            let indexPath:NSIndexPath = NSIndexPath(item: 0, section: 0)
            
            self.collectionView.selectItem(at: indexPath as IndexPath, animated: true, scrollPosition: .centeredHorizontally)
            
            self.arrowImageView.frame = CGRect(x: (UIScreen.main.bounds.size.width/5.0-13)*0.5 , y: self.height-7, width: 13.0, height: 7.0)
            
            self.animate(index: indexPath.row)
            
            
        }
        
    }
    
    // MARK: 2.选中索引（计算属性）
    public var seleted:NSInteger {
        get{
            return self.seletedIndex
        }set{
            self.seletedIndex = newValue;
            
            let indexPath:NSIndexPath = NSIndexPath(item: seletedIndex, section: 0)
            self.collectionView.selectItem(at: indexPath as IndexPath, animated: true, scrollPosition: .centeredHorizontally)
            
            self.animate(index: indexPath.row)
            
        }
        
    }
}

// MARK: - 【声明】协议 YUHorizScrollViewDelegate
protocol YUHorizScrollViewDelegate: NSObjectProtocol {
    func horizScrollView(_ view: YUHorizScrollView, didSelect index: Int) -> ()
}

// MARK: - 【扩展】实现协议 UICollectionViewDelegate
extension YUHorizScrollView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        // 更新cell的布局
        let cell: UICollectionViewCell = collectionView.cellForItem(at: indexPath)!
        cell.setNeedsLayout()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // 动态选中cell
        collectionView.selectItem(at: indexPath, animated: true, scrollPosition: .centeredHorizontally)
        // 获取cell
        let cell: UICollectionViewCell = collectionView.cellForItem(at: indexPath)!
        cell.setNeedsLayout()
        
        self.animate(index: indexPath.row)
 
        //调用代理
        if ((self.delegate) != nil)&&(self.delegate?.responds(to: Selector(("horizScrollView:didSelect:"))))! {
            self.delegate?.horizScrollView( self, didSelect: indexPath.row)
        }
  
    }
}
// MARK: - 【扩展】实现协议 UICollectionViewDataSource
extension YUHorizScrollView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.dataArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // 复用cell
        let cell:YUHorizScrollCell = collectionView.dequeueReusableCell(withReuseIdentifier: "YUHorizScrollCell", for: indexPath) as! YUHorizScrollCell
        
        cell.title = self.dataArray[indexPath.row] as! NSString;
        
        return cell;
    }
}


