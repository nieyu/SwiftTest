
//
//  UIViewExtension.swift
//  TestTransform
//
//  Created by nie yu on 2020/1/10.
//  Copyright © 2020 nie yu. All rights reserved.
//

import UIKit

var kGradientLayer: String = "kGradientLayer"
var kShadowLayer: String = "shadowLayer"

extension UIView {
    private var gradientLayer: CAGradientLayer? {
        set {
            objc_setAssociatedObject(self, &kGradientLayer, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
        }
        get {
            if let _gradientLayer = objc_getAssociatedObject(self, &kGradientLayer) as? CAGradientLayer {
                return _gradientLayer
            }
            return nil
        }
    }

    public var shadowLayer: CALayer? {
        set {
            objc_setAssociatedObject(self, &kShadowLayer, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
        }
        get {
            if let _shadowLayer = objc_getAssociatedObject(self, &kShadowLayer) as? CALayer {
                return _shadowLayer
            }
            return nil
        }
    }

    // MARK: 添加渐变色图层
    public func gradientColor(_ startPoint: CGPoint, _ endPoint: CGPoint, _ colors: [CGColor], _ frame: CGRect) {
        guard startPoint.x >= 0, startPoint.x <= 1,
            startPoint.y >= 0, startPoint.y <= 1,
            endPoint.x >= 0, endPoint.x <= 1,
            endPoint.y >= 0, endPoint.y <= 1 else {
                return
        }
        
        // 外界如果改变了self的大小，需要先刷新
        layoutIfNeeded()
//        removeGradientLayer()
        var gradientLayer: CAGradientLayer? = CAGradientLayer()
        gradientLayer?.frame = frame
        gradientLayer?.startPoint = startPoint
        gradientLayer?.endPoint = endPoint
    //        gradientLayer?.shadowOpacity = 0.0
        //        gradientLayer.locations = [0, 1]
        gradientLayer?.colors = colors
        gradientLayer?.cornerRadius = self.layer.cornerRadius
        gradientLayer?.masksToBounds = true
        // 渐变图层插入到最底层，避免在uibutton上遮盖文字图片
        self.layer.insertSublayer(gradientLayer!, at: 0)
    //        self.backgroundColor = UIColor.blue
        // self如果是UILabel，masksToBounds设为true会导致文字消失
        self.layer.masksToBounds = false
    }



    // MARK: 移除渐变图层
    // （当希望只使用backgroundColor的颜色时，需要先移除之前加过的渐变图层）
    public func removeGradientLayer() {
        gradientLayer?.removeFromSuperlayer()
    }
}
