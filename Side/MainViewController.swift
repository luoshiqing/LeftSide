//
//  MainViewController.swift
//  Side
//
//  Created by sqluo on 2016/11/17.
//  Copyright © 2016年 sqluo. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    public var navgationCtr: UINavigationController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        
        let btn = UIButton(frame: CGRect(x: (self.view.frame.width - 80) / 2, y: (self.view.frame.height - 30) / 2, width: 80, height: 30))
        
        
        btn.setTitle("下一个", for: UIControlState())
        btn.backgroundColor = UIColor.red
        
        btn.setTitleColor(UIColor.white, for: UIControlState())
        btn.addTarget(self, action: #selector(self.btnAct(send:)), for: .touchUpInside)
        self.view.addSubview(btn)

        
        
    }

    func btnAct(send: UIButton){
        let tmpVC = TmpViewController()
        tmpVC.navigationItem.title = "测试xx"
        tmpVC.hidesBottomBarWhenPushed = true
        self.navgationCtr?.pushViewController(tmpVC, animated: true)
    }
 
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
