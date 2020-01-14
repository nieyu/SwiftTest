//
//  ViewController.swift
//  TestTransform
//
//  Created by nie yu on 2020/1/10.
//  Copyright © 2020 nie yu. All rights reserved.
//

import UIKit

public enum SliderType {
    case tx, ty, a, b, c, d
}

public class ViewController: UIViewController {

    @IBOutlet weak var txSlider: UISlider!
    @IBOutlet weak var tySlider: UISlider!
    @IBOutlet weak var aSlider: UISlider!
    @IBOutlet weak var bSlider: UISlider!
    @IBOutlet weak var cSlider: UISlider!
    @IBOutlet weak var dSlider: UISlider!
    
    @IBOutlet weak var txValueLabel: UILabel!
    @IBOutlet weak var tyValueLabel: UILabel!
    @IBOutlet weak var aValueLabel: UILabel!
    @IBOutlet weak var bValueLabel: UILabel!
    @IBOutlet weak var cValueLabel: UILabel!
    @IBOutlet weak var dValueLabel: UILabel!
    
    @IBOutlet weak var transformView: UIView!
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        [txSlider, tySlider, aSlider, bSlider, cSlider, dSlider].forEach { (slider) in
            slider?.addTarget(self, action: #selector(sliderAction(_:)), for: .valueChanged)
        }
        txSlider.sliderType = .tx
        tySlider.sliderType = .ty
        aSlider.sliderType = .a
        bSlider.sliderType = .b
        cSlider.sliderType = .c
        dSlider.sliderType = .d
        
        let startPoint: CGPoint = CGPoint.init(x: 0, y: 0)
        let endPoint: CGPoint = CGPoint.init(x: 1, y: 1)
        let colors: [CGColor] = [UIColor.green.cgColor, UIColor.red.cgColor]
        let transformUpHalfFrame = CGRect.init(x: 0, y: 0, width: transformView.frame.size.width, height: transformView.frame.size.height * 0.5)
        transformView.gradientColor(startPoint, endPoint, colors, transformUpHalfFrame)
        
        
        let startPoint02: CGPoint = CGPoint.init(x: 1, y: 0)
        let endPoint02: CGPoint = CGPoint.init(x: 0, y: 1)
        let colors02: [CGColor] = [UIColor.blue.cgColor, UIColor.yellow.cgColor]
        let transformDownHalfFrame = CGRect.init(x: 0, y: transformView.frame.size.height * 0.5, width: transformView.frame.size.width, height: transformView.frame.size.height * 0.5)
        transformView.gradientColor(startPoint02, endPoint02, colors02, transformDownHalfFrame)
        
        transformView.layer.borderColor = UIColor.black.cgColor
        transformView.layer.borderWidth = 1
        print(transformView.transform)
        updateValue(transform: transformView.transform)
        updateSliderValue(transform: transformView.transform)
    }
    
    @IBAction func sliderAction(_ slider: UISlider) {
        var transform = transformView.transform
        let sliderValue: CGFloat = CGFloat(slider.value)
        if let sliderType = slider.sliderType {
            switch sliderType {
            case .tx:   transform.tx = sliderValue
            case .ty:   transform.ty = sliderValue
            case .a:    transform.a = sliderValue
            case .b:    transform.b = sliderValue
            case .c:    transform.c = sliderValue
            case .d:    transform.d = sliderValue
            }
        }
        transformView.transform = transform
        updateValue(transform: transform)
//        print(transformView.transform)
    }
    
    @IBAction func resetButtonAction(_ button: UIButton) {
        var transform = transformView.transform
        transform.tx = 0
        transform.ty = 0
        transform.a = 1
        transform.b = 0
        transform.c = 0
        transform.d = 1
        transformView.transform = transform
        updateValue(transform: transformView.transform)
        updateSliderValue(transform: transformView.transform)
    }
    
    private func updateValue(transform: CGAffineTransform) {
        txValueLabel.text = "\(transform.tx)"
        tyValueLabel.text = "\(transform.ty)"
        aValueLabel.text = "\(transform.a)"
        bValueLabel.text = "\(transform.b)"
        cValueLabel.text = "\(transform.c)"
        dValueLabel.text = "\(transform.d)"
    }
    
    private func updateSliderValue(transform: CGAffineTransform) {
        txSlider.value = Float(transform.tx)
        tySlider.value = Float(transform.ty)
        aSlider.value = Float(transform.a)
        bSlider.value = Float(transform.b)
        cSlider.value = Float(transform.c)
        dSlider.value = Float(transform.d)
    }

}

