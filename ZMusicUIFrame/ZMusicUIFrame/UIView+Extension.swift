//
//  UIView+Extension.swift
//  ZMusicUIFrame
//
//  Created by lyxia on 2016/10/24.
//  Copyright © 2016年 lyxia. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

fileprivate struct AssociatedKeys {
    static var bgImageKey: UInt8 = 0
}

extension UIView {
    public func setBackgroundImageWithPattern(_ image: UIImage?) {
        if let image = image {
            let bgColor = UIColor.init(patternImage: image)
            self.backgroundColor = bgColor
        } else {
            self.backgroundColor = nil
        }
    }
    
    public func setBackgroundImage(_ image: UIImage?) {
        if let image = image {
            self.bgImageView.image = nil
            self.bgImageView.image = image
        } else {
            self.bgImageView.image = nil
        }
    }
    
    var bgImageView: UIImageView {
        get {
            if let bgImageView = objc_getAssociatedObject(self, &AssociatedKeys.bgImageKey) as? UIImageView {
                return bgImageView
            }
            
            let bgImageView = UIImageView()
            bgImageView.translatesAutoresizingMaskIntoConstraints = false
            self.insertSubview(bgImageView, at: 0)
            bgImageView.contentMode = .scaleToFill
            bgImageView.snp.makeConstraints { [weak weakSelf = self](make) in
                if let weakSelf = weakSelf {
                    make.edges.equalTo(weakSelf)
                }
            }
            objc_setAssociatedObject(self, &AssociatedKeys.bgImageKey, bgImageView, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            return bgImageView
        }
    }
}

public extension UIView {
    public func screenShot() -> UIImage? {
        guard frame.size.height > 0 && frame.size.width > 0 else {
            return nil
        }
        
        UIGraphicsBeginImageContextWithOptions(frame.size, false, 0)
        layer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image
    }
    
    public func screenShot(withSize size:CGSize) -> UIImage? {
        guard frame.size.height > 0 && frame.size.width > 0 else {
            return nil
        }
        guard size.height > 0 && size.width > 0 else {
            return nil
        }
        
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        layer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image
    }
}
