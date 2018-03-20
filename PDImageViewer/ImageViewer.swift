//
//  ImageViewer.swift
//  PDImageViewer
//
//  Created by Lemonade on 2018/3/8.
//  Copyright © 2018年 Lemonade. All rights reserved.
//

import UIKit

class ImageViewer: UIView {
    /// 内容图数组
    public var contentImages = [UIImage]()
    /// 被点击图片初始位置(相对于屏幕,同时也是还原时候的位置)
    public var originFrame = CGRect.zero

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    init(contentImages: [UIImage] = [], originFrame: CGRect = CGRect.zero) {
        super.init(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        self.backgroundColor = UIColor.black
        self.alpha = 0.0
        let tapGR = UITapGestureRecognizer.init(target: self, action: #selector(hideImage(sender:)))
        self.addGestureRecognizer(tapGR)
        
        self.contentImages = contentImages
        self.originFrame = originFrame
    }
    
    func show() {
        if self.contentImages.count > 0 {
            let image = self.contentImages.first
            // 构造一个和被点击图片位置,内容一模一样的视图,如果不存在,则创建
            var newView = self.viewWithTag(1024) as? UIImageView
            if newView == nil {
                newView = UIImageView.init()
                newView!.tag = 1024
                self.addSubview(newView!)
            }
            newView?.frame = originFrame
            newView?.image = image
            
            let window = UIApplication.shared.keyWindow
            // 显示到window上
            window?.addSubview(self)
            // 动画效果显示
            UIView.animate(withDuration: 0.5) {
                let width = UIScreen.main.bounds.width
                let height = width * (image?.size.height)! / (image?.size.width)!
                let y = (UIScreen.main.bounds.height - height)/2
                
                newView!.frame = CGRect.init(x: 0, y: y, width: width, height: height)
                self.alpha = 1.0
            }
        }
    }
    
    // 隐藏图片浏览器
    @objc func hideImage(sender: UIGestureRecognizer) {
        let imgView = self.viewWithTag(1024)
        // 动画效果移除
        UIView.animate(withDuration: 0.5, animations: {
            // 原路返回
            imgView?.frame = self.originFrame
            self.alpha = 0.0
        }) { (completed) in
            self.removeFromSuperview()
        }
    }
}
extension UIView {
    static func getCorrectFrameFromOriginView(originView: UIView) -> CGRect {
        var correctX: CGFloat = 0
        var correctY: CGFloat = 0
        var tmpView = originView
        
        while tmpView.superview != nil {
            
            let frame = tmpView.frame
            
            
            correctX = correctX + frame.minX
            correctY = correctY + frame.minY
            
            tmpView = tmpView.superview!
            // 由于ScrollView存在contentOffset,因此对于ScrollView及其子类要做特殊判断
            if tmpView is UIScrollView {
                let scView = tmpView as! UIScrollView
                correctX = correctX - scView.contentOffset.x
                correctY = correctY - scView.contentOffset.y
            }
        }
        correctX = correctX + tmpView.frame.minX
        correctY = correctY + tmpView.frame.minY
        
        return CGRect.init(x: correctX, y: correctY, width: originView.frame.width, height: originView.frame.height)
    }
}
extension UIImage {
    /**
     *  重设图片大小
     */
    func reSizeImage(reSize:CGSize) -> UIImage {
        //UIGraphicsBeginImageContext(reSize);
        UIGraphicsBeginImageContextWithOptions(reSize, false, UIScreen.main.scale);
        self.draw(in: CGRect.init(x: 0, y: 0, width: reSize.width, height: reSize.height));
        let reSizeImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!;
        UIGraphicsEndImageContext();
        return reSizeImage;
    }
    
    /**
     *  等比率缩放
     */
    func scaleImage(scaleSize:CGFloat) -> UIImage {
        let reSize = CGSize.init(width: self.size.width * scaleSize, height: self.size.height * scaleSize)
        return reSizeImage(reSize: reSize)
    }
}

