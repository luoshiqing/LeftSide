//
//  SecondViewController.swift
//  Side
//
//  Created by sqluo on 2016/12/12.
//  Copyright © 2016年 sqluo. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.groupTableViewBackground
        
        
        
        let btn = UIButton(frame: CGRect(x: (self.view.frame.width - 80) / 2, y: (self.view.frame.height - 30) / 2, width: 80, height: 30))
        
        
        btn.setTitle("下一个", for: UIControlState())
        btn.backgroundColor = UIColor.red
        
        btn.setTitleColor(UIColor.white, for: UIControlState())
        btn.addTarget(self, action: #selector(self.btnAct(send:)), for: .touchUpInside)
        self.view.addSubview(btn)
        
        
    }
    
    func btnAct(send: UIButton){
        let tmpVC = TmpViewController()
        tmpVC.navigationItem.title = "测试"
        tmpVC.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(tmpVC, animated: true)
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
