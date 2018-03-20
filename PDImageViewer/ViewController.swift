//
//  ViewController.swift
//  PDImageViewer
//
//  Created by Lemonade on 2018/3/8.
//  Copyright © 2018年 Lemonade. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    lazy var imageViewer: ImageViewer = {
        let imgViewer = ImageViewer.init()
        return imgViewer
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        // 图片1
        let smallIV_1 = UIImageView.init()
        let img_1 = UIImage.init(named: "Racing_Saber")
        let size_1: CGSize = (img_1?.size)!
        smallIV_1.frame = CGRect.init(x: 50, y: 50, width: size_1.width/2, height: size_1.height/2)
        smallIV_1.image = img_1
        let tapGR_1 = UITapGestureRecognizer.init(target: self, action: #selector(showImageViewer(sender:)))
        smallIV_1.addGestureRecognizer(tapGR_1)
        smallIV_1.isUserInteractionEnabled = true
        self.view.addSubview(smallIV_1)

//        self.navigationController?.setNavigationBarHidden(true, animated: false)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func showImageViewer(sender: UIGestureRecognizer) {
        let imgView = sender.view as! UIImageView
        imageViewer.contentImages = [imgView.image!]
        let frame = UIView.getCorrectFrameFromOriginView(originView: imgView)
        imageViewer.originFrame = frame
        imageViewer.show()
    }
}


