//
//  PointView.swift
//  IOSUnLockGesturesView
//
//  Created by 乔晓松 on 2018/3/19.
//  Copyright © 2018年 coolspan. All rights reserved.
//

import UIKit

class PointView: UIView {
    
    private var borderLayer: CAShapeLayer!
    private var centerDotLayer: CAShapeLayer!
    private var whiteShadowLayer: CAShapeLayer!
    
    var ID: Int!
    
    var isSelected: Bool = false {
        didSet {
            if isSelected {
                centerDotLayer.isHidden = false
                borderLayer.strokeColor = UIColor.init(red: 59 / 255, green: 141 / 255, blue: 178 / 255, alpha: 1).cgColor
            } else {
                centerDotLayer.isHidden = true
                borderLayer.strokeColor = UIColor.init(red: 83 / 255, green: 86 / 255, blue: 89 / 255, alpha: 1).cgColor
            }
        }
    }
    
    var isSuccess: Bool = false {
        didSet {
            if isSuccess {
                
            } else {
                
            }
        }
    }
    
    var isError: Bool = false {
        didSet {
            if isError {
                
            } else {
                
            }
        }
    }
    
    init(frame: CGRect, id: Int) {
        super.init(frame: frame)
        self.ID = id
        initSubviews(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// MARK: - private methods
private extension PointView {
    
    func initSubviews(frame: CGRect) -> Void {
        addBorderLayer()
        addWhiteShadowLayer()
        addCenterDotLayer()
    }
    
    func addCenterDotLayer() {
        centerDotLayer = CAShapeLayer()
        centerDotLayer.isHidden = true
        let path = UIBezierPath.init(arcCenter: CGPoint(x: frame.size.width / 2, y: frame.size.height / 2), radius: (frame.size.width - 2.5) / 2 / 3, startAngle: 0, endAngle: CGFloat(2 * Double.pi), clockwise: false)
        centerDotLayer.path = path.cgPath
        centerDotLayer.backgroundColor = UIColor.clear.cgColor
        centerDotLayer.fillColor = UIColor.init(red: 21 / 255, green: 166 / 255, blue: 244 / 255, alpha: 1).cgColor
        centerDotLayer.strokeColor = UIColor.init(red: 17 / 255, green: 18 / 255, blue: 19 / 255, alpha: 1).cgColor
        centerDotLayer.lineWidth = 2.5
        centerDotLayer.frame = CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height)
        layer.insertSublayer(centerDotLayer, above: whiteShadowLayer)
    }
    
    func addBorderLayer() {
        borderLayer = CAShapeLayer()
        let path = UIBezierPath.init(arcCenter: CGPoint(x: frame.size.width / 2, y: frame.size.height / 2), radius: (frame.size.width - 2.5) / 2, startAngle: 0, endAngle: CGFloat(2 * Double.pi), clockwise: false)
        borderLayer.path = path.cgPath
        borderLayer.backgroundColor = UIColor.clear.cgColor
        borderLayer.fillColor = UIColor.clear.cgColor
        borderLayer.strokeColor = UIColor.init(red: 83 / 255, green: 86 / 255, blue: 89 / 255, alpha: 0.5).cgColor
        borderLayer.lineWidth = 2.5
        borderLayer.frame = CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height)
        layer.addSublayer(borderLayer)
    }
    
    func addWhiteShadowLayer() -> Void {
        whiteShadowLayer = CAShapeLayer()
        let path = UIBezierPath.init(arcCenter: CGPoint(x: frame.size.width / 2, y: frame.size.height / 2), radius: (frame.size.width - 7.5) / 2, startAngle: 0, endAngle: CGFloat(2 * Double.pi), clockwise: false)
        whiteShadowLayer.path = path.cgPath
        whiteShadowLayer.backgroundColor = UIColor.clear.cgColor
        whiteShadowLayer.fillColor = UIColor.init(red: 1, green: 1, blue: 1, alpha: 0.1).cgColor
        whiteShadowLayer.strokeColor = UIColor.clear.cgColor
        whiteShadowLayer.frame = CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height)
        layer.addSublayer(whiteShadowLayer)
    }
}
