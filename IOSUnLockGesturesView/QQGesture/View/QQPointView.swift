//
//  QQPointView.swift
//  IOSUnLockGesturesView
//
//  Created by 乔晓松 on 2018/3/20.
//  Copyright © 2018年 coolspan. All rights reserved.
//

import UIKit

class QQPointView: UIView {
    
    private var borderLayer: CAShapeLayer!
    private var selectedBgLayer: CAShapeLayer!
    private var centerDotLayer: CAShapeLayer!
    
    var ID: Int!
    var isSelected: Bool = false {
        didSet {
            if isSelected {
                selectedBgLayer.isHidden = false
                borderLayer.strokeColor = UIColor.init(red: 59 / 255, green: 141 / 255, blue: 178 / 255, alpha: 1).cgColor
                borderLayer.isHidden = true
                centerDotLayer.isHidden = false
            } else {
                selectedBgLayer.isHidden = true
                borderLayer.strokeColor = UIColor.init(red: 83 / 255, green: 86 / 255, blue: 89 / 255, alpha: 1).cgColor
                borderLayer.isHidden = false
                centerDotLayer.isHidden = true
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
private extension QQPointView {
    
    func initSubviews(frame: CGRect) -> Void {
        addBorderLayer()
        addSelectedBgLayer()
        addCenterDotLayer()
    }
    
    func addSelectedBgLayer() {
        selectedBgLayer = CAShapeLayer()
        selectedBgLayer.isHidden = true
        let path = UIBezierPath.init(arcCenter: CGPoint(x: frame.size.width / 2, y: frame.size.height / 2), radius: (frame.size.width) / 2 / 5 * 3.5, startAngle: 0, endAngle: CGFloat(2 * Double.pi), clockwise: false)
        selectedBgLayer.path = path.cgPath
        selectedBgLayer.backgroundColor = UIColor.clear.cgColor
        selectedBgLayer.fillColor = UIColor.clear.cgColor
        selectedBgLayer.strokeColor = UIColor.init(red: 17 / 255, green: 141 / 255, blue: 222 / 255, alpha: 0.4).cgColor
        selectedBgLayer.lineWidth = (frame.size.width) / 2 / 5 * 3
        selectedBgLayer.frame = CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height)
        layer.insertSublayer(selectedBgLayer, above: centerDotLayer)
    }
    
    func addBorderLayer() {
        borderLayer = CAShapeLayer()
        let path = UIBezierPath.init(arcCenter: CGPoint(x: frame.size.width / 2, y: frame.size.height / 2), radius: (frame.size.width - 2.5) / 2, startAngle: 0, endAngle: CGFloat(2 * Double.pi), clockwise: false)
        borderLayer.path = path.cgPath
        borderLayer.backgroundColor = UIColor.clear.cgColor
        borderLayer.fillColor = UIColor.clear.cgColor
        borderLayer.strokeColor = UIColor.init(red: 123 / 255, green: 123 / 255, blue: 124 / 255, alpha: 1).cgColor
        borderLayer.lineWidth = 1.5
        borderLayer.frame = CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height)
        layer.addSublayer(borderLayer)
    }
    
    func addCenterDotLayer() -> Void {
        centerDotLayer = CAShapeLayer()
        centerDotLayer.isHidden = true
        let path = UIBezierPath.init(arcCenter: CGPoint(x: frame.size.width / 2, y: frame.size.height / 2), radius: (frame.size.width) / 2 / 5 * 2, startAngle: 0, endAngle: CGFloat(2 * Double.pi), clockwise: false)
        centerDotLayer.path = path.cgPath
        centerDotLayer.backgroundColor = UIColor.clear.cgColor
        centerDotLayer.fillColor = UIColor.init(red: 17 / 255, green: 141 / 255, blue: 222 / 255, alpha: 1).cgColor
        centerDotLayer.strokeColor = UIColor.clear.cgColor
        centerDotLayer.frame = CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height)
        layer.addSublayer(centerDotLayer)
    }
}
