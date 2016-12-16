//
//  BaseTabBarController.swift
//  Side
//
//  Created by sqluo on 2016/12/12.
//  Copyright © 2016年 sqluo. All rights reserved.
//

import UIKit

class BaseTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
        self.creatSubVCs()
        
    }

    
    func creatSubVCs(){
        
        //1.0
        let mainVC = MainViewController()
        
        
        let leftVC = LeftViewController()
        leftVC.dataArray = ["第一","saf","efefe","32423rfs","dsgssdc5256dsg"]

        let sideVC = SideViewController(mainVC: mainVC, leftCtr: leftVC, tabBar: self.tabBar)
        
        let sideNav = BaseNavigationController(rootViewController: sideVC)
        
        sideNav.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.white]
        sideNav.navigationBar.barTintColor = UIColor(red: 246/255.0, green: 93/255.0, blue: 34/255.0, alpha: 1)
        
        sideNav.tabBarItem = UITabBarItem(title: "第一", image: UIImage(named: "homeA")?.withRenderingMode(.alwaysOriginal), selectedImage: UIImage(named: "homeL")?.withRenderingMode(.alwaysOriginal))
        //2.0
        let secondVC = SecondViewController()
        let tow = BaseNavigationController(rootViewController: secondVC)
        tow.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.white]
        tow.navigationBar.barTintColor = UIColor(red: 246/255.0, green: 93/255.0, blue: 34/255.0, alpha: 1)
        tow.tabBarItem = UITabBarItem(title: "第二", image: UIImage(named: "reportA")?.withRenderingMode(.alwaysOriginal), selectedImage: UIImage(named: "reportL")?.withRenderingMode(.alwaysOriginal))
        //3.0
        let thirdVC = ThirdViewController()
        let three = BaseNavigationController(rootViewController: thirdVC)
        three.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.white]
        three.navigationBar.barTintColor = UIColor(red: 246/255.0, green: 93/255.0, blue: 34/255.0, alpha: 1)
        three.tabBarItem = UITabBarItem(title: "第三", image: UIImage(named: "messageA")?.withRenderingMode(.alwaysOriginal), selectedImage: UIImage(named: "messageL")?.withRenderingMode(.alwaysOriginal))
        
        //4.0
        let fourVC = FourthViewController()
        let four = BaseNavigationController(rootViewController: fourVC)
        four.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.white]
        four.navigationBar.barTintColor = UIColor(red: 246/255.0, green: 93/255.0, blue: 34/255.0, alpha: 1)
        four.tabBarItem = UITabBarItem(title: "第亖", image: UIImage(named: "shopA")?.withRenderingMode(.alwaysOriginal), selectedImage: UIImage(named: "shopL")?.withRenderingMode(.alwaysOriginal))
        
        //添加到控制器数组
        let tabArray = [sideNav,tow,three,four]
        self.viewControllers = tabArray
        //设置文字的颜色
        UITabBarItem.appearance().setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.gray], for: .normal)
        
        UITabBarItem.appearance().setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.orange], for: .selected)
        
    }
    

    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
