//
//  ViewExtension.swift
//  Swift仿写1_礼物说
//
//  Created by Guangquan Yu on 2017/9/4.
//  Copyright © 2017年 Guangquan Yu. All rights reserved.
//

import Foundation
import UIKit
//MARK: - UIView
extension UIView{
    // MARK: 1.圆角
    func radiusBorder(_ radius: CGFloat, borderColor:UIColor?, borderWidth:CGFloat) -> () {
        
        if ((borderColor) != nil) {
            self.layer.borderColor = borderColor?.cgColor
        }
        if borderWidth > 0 {
            self.layer.borderWidth = borderWidth
        }
        if radius > 0 {
            self.layer.cornerRadius = radius
        }
        
        self.layer.masksToBounds = true;
        
    }
    
    // MARK?: 2.添加一组子视图
    func addSubviews(_ array:[UIView]) -> () {
        
        for i in 0..<array.count {
           self.addSubview(array[i] )
        }
        
    }
}

//MARK: - UITableViewCell
extension UITableViewCell{
    // MARK: 1.修复cell，在创建cell的代理中使用
    func repairTableCell() -> () {
        self.selectionStyle = .none
        //判断某个类属性是否存在的方法
        if (self.responds(to: #selector(setter: UITableViewCell.layoutMargins))) {
            self.layoutMargins = UIEdgeInsets()
        }
        if (self.responds(to: #selector(setter: UITableViewCell.separatorInset))) {
            self.separatorInset = UIEdgeInsets()
        }
    }
    
    
    
}


//MARK: - UITableView
extension UITableView{
    // MARK: 1.重新布局某个cell
    func reLayoutForCell(_ indexPath: IndexPath) -> (UITableViewCell) {
        let cell: UITableViewCell = self.cellForRow(at: indexPath )!
        cell.setNeedsLayout()
        return cell
    }

    
}

//MARK: - UICollectionView
extension UICollectionView{
    // MARK: 1.重新布局某个cell
    func reLayoutForCell(_ indexPath: IndexPath) -> (UICollectionViewCell) {
        let cell: UICollectionViewCell = self.cellForItem(at: indexPath)!
        cell.setNeedsLayout()
        return cell
    }
  
}



