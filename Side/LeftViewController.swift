//
//  LeftViewController.swift
//  Side
//
//  Created by sqluo on 2016/11/17.
//  Copyright © 2016年 sqluo. All rights reserved.
//

import UIKit


public protocol LeftViewControllerDelegate: NSObjectProtocol {
    func didSelectRowAt(indexPath: IndexPath,name: String)
}


class LeftViewController: UIViewController ,UITableViewDelegate ,UITableViewDataSource{

    public weak var delegate: LeftViewControllerDelegate?
    
    public var myTabView: UITableView?
    
    public var dataArray = [String]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        let rect = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width - pageDistance, height: UIScreen.main.bounds.height)
        self.myTabView = UITableView(frame: rect, style: .plain)
        
        self.myTabView?.delegate = self
        self.myTabView?.dataSource = self
        
        self.myTabView?.tableFooterView = UIView()
        
        
        self.view.addSubview(self.myTabView!)
        
        
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataArray.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let tableViewCellIdentifier = "Cell"
        
        var cell = tableView.dequeueReusableCell(withIdentifier: tableViewCellIdentifier)
        
        if cell == nil {
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: tableViewCellIdentifier)
        }
        
        cell?.accessoryType = .disclosureIndicator
        cell?.textLabel?.text = self.dataArray[indexPath.row]
        
        
        return cell!
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        self.delegate?.didSelectRowAt(indexPath: indexPath ,name: self.dataArray[indexPath.row])
        
    }
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
