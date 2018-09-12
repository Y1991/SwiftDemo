//
//  YUBaseNavigationController.swift
//  Swift仿写1_礼物说
//
//  Created by Guangquan Yu on 2017/9/1.
//  Copyright © 2017年 Guangquan Yu. All rights reserved.
//

import UIKit
// MARK: - 【类】
class YUBaseNavigationController: UINavigationController {
   
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupNavigation()
    }

    
}

// MARK: - 【扩展】私有方法
extension YUBaseNavigationController{
    func setupNavigation() -> () {
        NSObject.makeNavigationBar()
        self.title = self.tabBarItem.title
        
    }


}
