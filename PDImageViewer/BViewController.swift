//
//  BViewController.swift
//  PDImageViewer
//
//  Created by Lemonade on 2018/3/13.
//  Copyright © 2018年 Lemonade. All rights reserved.
//

import UIKit

class BViewController: UIViewController {
    
    let kDefaultImageViewTag = 20000
    
    var myTableView: UITableView?
    
    lazy var imageViewer: ImageViewer = {
        let imgViewer = ImageViewer.init()
        return imgViewer
    }()
    
    var imageArr = [UIImage]()
    
    var heightArr = [CGFloat]()
    
    // MARK: - Life Circle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        requestData()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        myTableView?.delegate = self
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        myTableView?.delegate = nil
    }
    // MARK: - Private Methods
    private func requestData() {
        // 模拟数据获取与整合
        for i in 0..<10 {
            if i % 2 == 0 {
                let img = UIImage.init(named: "Racing_Saber")
                imageArr.append(img!)
                heightArr.append((img?.size.height)!/2 + 30)
            } else {
                let img = UIImage.init(named: "Gender_Alter")
                imageArr.append(img!)
                heightArr.append((img?.size.height)!/2 + 30)
            }
        }
        myTableView?.reloadData()
    }
    private func setUpUI() {
        myTableView = UITableView.init(frame: CGRect.init(x: 0, y: 0, width: DimensionConst.screenWidth, height: DimensionConst.screenHeight - (DimensionConst.statusBarHeight + DimensionConst.navigationBarHeight)), style: .grouped)
        myTableView?.backgroundColor = UIColor.white
        self.view.addSubview(myTableView!)
        
//        myTableView?.estimatedRowHeight = 0
//        myTableView?.estimatedSectionHeaderHeight = 0
//        myTableView?.estimatedSectionFooterHeight = 0
//        if #available(iOS 11.0, *) {
//            myTableView?.contentInsetAdjustmentBehavior = .never
//        } else {
//            self.automaticallyAdjustsScrollViewInsets = false
//        }
        
        /*
         *
         *  解决tableView向下偏移一段距离的问题
         *
         */
        
        let headView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: 0, height: 0.01))
        myTableView?.tableHeaderView = headView
        myTableView?.tableFooterView = headView
        
        myTableView?.dataSource = self
        
    }
    @objc func showImageViewer(sender: UIGestureRecognizer) {
        let imgView = sender.view as! UIImageView
        imageViewer.contentImages = imageArr
        let frame = UIView.getCorrectFrameFromOriginView(originView: imgView)
        imageViewer.originFrame = frame
        if (imgView.tag - kDefaultImageViewTag) >= 0 {
            imageViewer.selectedIndex = imgView.tag - kDefaultImageViewTag
        }
        imageViewer.show()
    }
}
// MARK: - UITableViewDataSource
extension BViewController: UITableViewDataSource {
    
    static let cellIdentifyA = "cellIdentifyA"
    static let cellIdentifyB = "cellIdentifyB"
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return imageArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = indexPath.row
        if (row % 2) == 0 {
            var cellA = tableView.dequeueReusableCell(withIdentifier: BViewController.cellIdentifyA)
            if cellA == nil {
                cellA = UITableViewCell.init(style: .default, reuseIdentifier: BViewController.cellIdentifyA)
                cellA?.imageView?.contentMode = .scaleAspectFit
                cellA?.imageView?.isUserInteractionEnabled = true
                
            cellA?.imageView?.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(showImageViewer(sender:))))
            }
            cellA?.imageView?.tag = kDefaultImageViewTag + indexPath.row
            cellA?.imageView?.image = imageArr[row].scaleImage(scaleSize: 0.5)
            return cellA!
        } else {
            var cellB = tableView.dequeueReusableCell(withIdentifier: BViewController.cellIdentifyB)
            if cellB == nil {
                cellB = UITableViewCell.init(style: .default, reuseIdentifier: BViewController.cellIdentifyB)
                cellB?.imageView?.isUserInteractionEnabled = true
                cellB?.imageView?.contentMode = .scaleAspectFit
                cellB?.imageView?.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(showImageViewer(sender:))))
            }
            cellB?.imageView?.tag = kDefaultImageViewTag + indexPath.row
            cellB?.imageView?.image = imageArr[row].scaleImage(scaleSize: 0.5)
            return cellB!
        }
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return nil
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return heightArr[indexPath.row]
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.01
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        // 分割线左侧不留白
        cell.separatorInset = .zero
        cell.layoutMargins = .zero
        cell.preservesSuperviewLayoutMargins = false
        
        cell.selectionStyle = .none
    }
}
// MARK: - UITableViewDelegate
extension BViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
