//
//  MenuViewController.swift
//  PDImageViewer
//
//  Created by Lemonade on 2018/3/9.
//  Copyright © 2018年 Lemonade. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {

    private var menuTableView: UITableView?
    // MARK: - 生命周期
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        menuTableView?.delegate = self
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        menuTableView?.delegate = nil
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setUpUI() {
        self.title = "菜单"
        
        menuTableView = UITableView.init(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height), style: .grouped)
        menuTableView!.dataSource = self
        self.view.addSubview(menuTableView!)
    }

}
extension MenuViewController: UITableViewDataSource, UITableViewDelegate {
    
    static let cellIdentify = "cellIdentify"
    
    var titleList: Array<String> {
        return ["单张图片", "tableView图片", "collectionView图片"]
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: MenuViewController.cellIdentify)
        if cell == nil {
            cell = UITableViewCell.init(style: .default, reuseIdentifier: MenuViewController.cellIdentify)
        }
        cell!.textLabel?.text = titleList[indexPath.row]
        return cell!
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return nil
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.row == 0 {
            self.navigationController?.pushViewController(ViewController(), animated: true)
//            self.present(ViewController(), animated: true, completion: nil)
        } else if indexPath.row == 1 {
            self.navigationController?.pushViewController(BViewController(), animated: true)
        } else {
            self.navigationController?.pushViewController(CViewController(), animated: true)
        }
    }
    
    
}
