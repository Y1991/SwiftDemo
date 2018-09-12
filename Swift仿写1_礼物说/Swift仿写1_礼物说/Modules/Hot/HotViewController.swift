//
//  HotViewController.swift
//  Swift仿写1_礼物说
//
//  Created by Guangquan Yu on 2017/8/31.
//  Copyright © 2017年 Guangquan Yu. All rights reserved.
//

import UIKit



class HotViewController: UIViewController {
    //MARK: 1.System method
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = self.tabBarItem.title
        self.automaticallyAdjustsScrollViewInsets = false
        
        
        self.makeUI()
        self.makeFrame()
        self.loadData()
        
        
    }
    
    //MARK: 2.UI
    fileprivate func makeUI() {
        self.view.addSubview(self.collectionView)
 
    }
    
    //MARK: 3.Frame
    fileprivate func makeFrame() {
        
        self.collectionView.snp.makeConstraints { (make) in
            make.top.left.bottom.right.equalToSuperview()
        }
    }
    
    //MARK: 4.加载数据
    fileprivate func loadData() {
        let mArr = NSMutableArray.init(capacity: 10)
        for _ in 0..<50 {

            mArr.add(NSString.init(format: "goods_%d.jpg", arc4random()%9))
        }
        
        self.data = mArr
    }


    //MARK: 5.懒加载
    fileprivate lazy var collectionView:UICollectionView = {
        let collectionView = NSObject.createCollectionView(CGRect(), delegate: self, cellClass: YUHorizScrollCellTwo.self, cellIdentifier: "YUHorizScrollCellTwo", scrollDirection: .vertical, backColor: UIColor.white)
        
        return collectionView
    }()
    
    //MARK: 6.存储属性
    fileprivate var dataArray:NSArray = []
    fileprivate var seletedIndex:NSInteger = 0
    

}

// MARK: - 【扩展】外界赋值
extension HotViewController {
    
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

// MARK: - 【扩展】实现协议 UICollectionViewDelegate
extension HotViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}

// MARK: - 【扩展】实现协议 UICollectionViewDataSource
extension HotViewController: UICollectionViewDataSource {
    
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

// MARK: - 【扩展】实现协议 UICollectionViewDelegateFlowLayout
extension HotViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 89, height: 113)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let count: NSInteger = 4
        let edgeW: CGFloat = (UIScreen.main.bounds.size.width-CGFloat(count*89)-CGFloat(count-1)*3)/2.0;
        
        return UIEdgeInsetsMake(3, edgeW, 10, edgeW);
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 3
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 3
    }
}









