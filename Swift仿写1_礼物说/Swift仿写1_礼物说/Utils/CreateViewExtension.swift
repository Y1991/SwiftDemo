
//
//  CreateViewExtension.swift
//  Swift仿写1_礼物说
//
//  Created by Guangquan Yu on 2017/9/1.
//  Copyright © 2017年 Guangquan Yu. All rights reserved.
//

import Foundation
import UIKit

extension NSObject{

    //MARK: UIButton
    static func createButton(_ title:NSString?, titleColor:UIColor?, imageName:NSString?, frame: CGRect, target: Any?, action: Selector) -> UIButton {
        let btn = UIButton(type: .custom)   //枚举需要使用'.'来定义类型
        btn.frame = frame
        // 字体
        //选中的
        //        btn.backgroundColor = UIColor.brown
        if title != nil {
            btn.setTitle(title as String?, for: .normal)
            
            if titleColor != nil {
                btn.setTitleColor(titleColor, for: .normal)
            }
        }
        if imageName != nil {
            btn.setImage(UIImage.init(named: (imageName as String?)!), for: .normal)
        }
        
        //        btn.contentHorizontalAlignment = UIControlContentHorizontalAlignment.left
        //        self.view.addSubview(btn)
        //        //添加事件
        btn.addTarget(target, action: action, for: .touchUpInside)
        return btn
    }
    
    //MARK: UIBarButtonItem
    static func createBarButtonItem(_ title:NSString?, titleColor:UIColor?, imageName:NSString?, target: Any?, action: Selector) -> UIBarButtonItem {
        let btn = createButton(title, titleColor: titleColor, imageName: imageName, frame: CGRect(x: 0, y: 0, width: 44, height: 44) , target: target, action: action)
        //        btn.contentHorizontalAlignment = UIControlContentHorizontalAlignment.left
        //        self.view.addSubview(btn)
        //        //添加事件
        //        btn.addTarget(self, action: #selector(CreateUI.clickButton), for: .touchUpInside)
        
        
        let barItem:UIBarButtonItem = UIBarButtonItem(customView: btn)
        return barItem
    }
    
    
    //MARK: UIImageView
    static func createImageView(_ imageName: NSString?, contentMode: UIViewContentMode, frame:CGRect) -> UIImageView {
        
        let imageView = UIImageView()
        if imageName != nil {
            let image = UIImage(named: (imageName as String?)!)
            imageView.image = image
        }
        
        imageView.contentMode = contentMode
        imageView.frame = frame
        return imageView
    }
    
    //MARK: UIView
    static func createView(_ backColor: UIColor?, frame:CGRect) -> UIView {
        let view = UIView(frame: frame)
        view.backgroundColor = backColor
        return view
    }
    
    //MARK: UILabel
    static func createUILabel(_ title:NSString?, titleColor:UIColor?, font: UIFont, textAlignment: NSTextAlignment, frame: CGRect) -> UILabel {
        let label = UILabel();
        label.frame = frame
        label.text = title as String?
        label.textColor = titleColor
        label.font = font
        label.textAlignment = textAlignment;
//        label.backgroundColor
        return label;
    }
    
    
    //MARK: UITableView
    static func createTableView(_ frame: CGRect, delegate: NSObjectProtocol, cellClass: AnyClass?, cellIdentifier: NSString ) -> UITableView {
        
        
        let tableView = UITableView(frame: frame, style: .grouped)
        tableView.backgroundColor = UIColor.white
        tableView.separatorStyle = .none
        
//        tableView.tableHeaderView = headView;
        
        if (tableView.responds(to: #selector(setter: UITableView.separatorInset))) {
            tableView.separatorInset = .zero
        }
        if (tableView.responds(to: #selector(setter: UITableView.layoutMargins))) {
            tableView.layoutMargins = .zero
        }

        //设置代理
        unowned let weakDelegate:NSObjectProtocol = delegate;
        tableView.dataSource = weakDelegate as? UITableViewDataSource;
        tableView.delegate = weakDelegate as? UITableViewDelegate;
        
        // 注册cell
        tableView.register(cellClass, forCellReuseIdentifier: (cellIdentifier as String))
        return tableView
    }
    
    //MARK: UICollectionView
    static func createCollectionView(_ frame: CGRect, delegate: NSObjectProtocol, cellClass: AnyClass?, cellIdentifier: NSString, scrollDirection: UICollectionViewScrollDirection, backColor: UIColor) -> UICollectionView {
  
        let collectionView = UICollectionView(frame: frame, collectionViewLayout: NSObject.createCollectionViewFlowLayout(CGSize(), minimumLineSpacing: 0, minimumInteritemSpacing: 0, scrollDirection: scrollDirection))
        
        //设置代理
        unowned let weakDelegate:NSObjectProtocol = delegate;
        collectionView.delegate                       = weakDelegate as? UICollectionViewDelegate
        collectionView.dataSource                     = weakDelegate as? UICollectionViewDataSource
        collectionView.isScrollEnabled                  = true;
        collectionView.showsHorizontalScrollIndicator = false;
        collectionView.backgroundColor                = backColor
        //collectionView.alwaysBounceHorizontal         = true;
        

        collectionView.register(cellClass, forCellWithReuseIdentifier: cellIdentifier as String)
        
        return collectionView
    }
    //MARK: FlowLayout
    static func createCollectionViewFlowLayout(_ itemSize: CGSize, minimumLineSpacing: CGFloat, minimumInteritemSpacing: CGFloat, scrollDirection: UICollectionViewScrollDirection ) -> UICollectionViewFlowLayout{
        let flowLayout = UICollectionViewFlowLayout()
        
        flowLayout.itemSize = itemSize
        
        flowLayout.minimumLineSpacing      = minimumLineSpacing
        flowLayout.minimumInteritemSpacing = minimumInteritemSpacing
        flowLayout.scrollDirection  = scrollDirection
        return flowLayout
    }
    
    //MARK: scrollView
    static func createScrollView(_ frame: CGRect,  delegate: NSObjectProtocol, pagingEnabled:Bool, bounces:Bool, showsHorizontalScrollIndicator:Bool, showsVerticalScrollIndicator:Bool) -> UIScrollView{
        
        //设置代理
        unowned let weakDelegate:NSObjectProtocol = delegate;
        
        let scrollView = UIScrollView(frame: frame)
        scrollView.isPagingEnabled = pagingEnabled//这个莫名失效了（不分页了）
        scrollView.isScrollEnabled = true
        scrollView.bounces = bounces
        scrollView.showsHorizontalScrollIndicator = showsHorizontalScrollIndicator
        scrollView.showsVerticalScrollIndicator = showsVerticalScrollIndicator
        
        scrollView.delegate = weakDelegate as?UIScrollViewDelegate
        return scrollView
    }

    //MARK: pageControl
    static func createPageControl(_ frame: CGRect, bgColor: UIColor?, currentPageIndicatorTintColor: UIColor?, pageIndicatorTintColor: UIColor?) -> UIPageControl{
        
        let pageControl = UIPageControl(frame: frame)
        //        //设置点的个数
        //        _pageControl.numberOfPages = COUNT;
        //设置背景颜色
        pageControl.backgroundColor = bgColor
        //点选中时的颜色
        pageControl.currentPageIndicatorTintColor = currentPageIndicatorTintColor
        //设置页码指示器的颜色
        pageControl.pageIndicatorTintColor = pageIndicatorTintColor
        
        //添加在self.view上 而不是scrollView 相对于屏幕不动

        //系统默认选中第一个点 如果想修改 只需要修改pageControl.currentPage
        // _pageControl.currentPage = 1;
        return pageControl
    }
    




}
