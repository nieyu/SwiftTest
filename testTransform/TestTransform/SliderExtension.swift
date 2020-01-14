//
//  SliderExtension.swift
//  TestTransform
//
//  Created by nie yu on 2020/1/10.
//  Copyright © 2020 nie yu. All rights reserved.
//

import UIKit


extension UISlider {
    
    private struct AssociatedKeys {
        static var sliderTypeKey = "sliderType"
    }
    
    var sliderType: SliderType? {
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.sliderTypeKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_COPY_NONATOMIC)
        }
        get {
            if let value = objc_getAssociatedObject(self, &AssociatedKeys.sliderTypeKey) as? SliderType {
                return value
            }
            return nil
        }
    }
}


