//
//  CViewController.swift
//  PDImageViewer
//
//  Created by Lemonade on 2018/3/15.
//  Copyright © 2018年 Lemonade. All rights reserved.
//

import UIKit

class CViewController: UIViewController {
    
    lazy var imageViewer: ImageViewer = {
        let imgViewer = ImageViewer.init()
        return imgViewer
    }()
    
    var myCollectionView: UICollectionView?
    
    var imageArr = [UIImage]()
    // MARK: - Life Circle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        requestData()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        myCollectionView?.delegate = self
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        myCollectionView?.delegate = nil
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    // MARK: - Private Methods
    func setUpUI() {
        
        self.view.backgroundColor = UIColor.white
        
        let flowLayout = UICollectionViewFlowLayout.init()
//        flowLayout.itemSize = CGSize.init(width: 160, height: 200)
//        flowLayout.sectionInset = UIEdgeInsets.init(top: 10, left: 10, bottom: 10, right: 10)
//        flowLayout.minimumLineSpacing = 20
//        flowLayout.minimumInteritemSpacing = 10
        flowLayout.scrollDirection = .vertical
        
        myCollectionView = UICollectionView.init(frame: CGRect.init(x: 0, y: 0, width: DimensionConst.screenWidth, height: DimensionConst.screenHeight - (DimensionConst.statusBarHeight + DimensionConst.navigationBarHeight)), collectionViewLayout: flowLayout)
        myCollectionView?.backgroundColor = UIColor.white
        myCollectionView?.register(UICollectionViewCell.classForCoder(), forCellWithReuseIdentifier: CViewController.cellIdentify)
        myCollectionView?.dataSource = self
        self.view.addSubview(myCollectionView!)
    }
    private func requestData() {
        // 模拟数据获取与整合
        for i in 0..<10 {
            if i % 2 == 0 {
                let img = UIImage.init(named: "Racing_Saber")
                imageArr.append(img!)
            } else {
                let img = UIImage.init(named: "Gender_Alter")
                imageArr.append(img!)
            }
        }
        myCollectionView?.reloadData()
    }
    
    @objc func showImageViewer(sender: UIGestureRecognizer) {
        let imgView = sender.view as! UIImageView
        imageViewer.contentImages = [imgView.image!]
        let frame = UIView.getCorrectFrameFromOriginView(originView: imgView)
        imageViewer.originFrame = frame
        imageViewer.show()
    }
}
// MARK: - UICollectionViewDataSource
extension CViewController: UICollectionViewDataSource {
    
    static let cellIdentify = "cellIdentify"
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CViewController.cellIdentify, for: indexPath)
//        cell.backgroundColor = UIColor.gray
        var imgView = cell.contentView.viewWithTag(1024) as? UIImageView
        if imgView == nil {
            imgView = UIImageView.init(frame: CGRect.init(x: 0, y: 0, width: 170, height: 200))
            imgView?.contentMode = .scaleAspectFill
            imgView?.clipsToBounds = true
            imgView?.tag = 1024
            imgView?.isUserInteractionEnabled = true
            imgView?.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(showImageViewer(sender:))))
            cell.contentView.addSubview(imgView!)
        }
        imgView?.image = imageArr[indexPath.row]
        
        return cell
    }
    
}
// MARK: - UICollectionViewDelegate
extension CViewController: UICollectionViewDelegate {
}
// MARK: - UICollectionViewDelegateFlowLayout
extension CViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: 170, height: 200)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.init(top: 10, left: 10, bottom: 10, right: 10)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
}
