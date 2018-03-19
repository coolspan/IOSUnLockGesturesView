//
//  PointView.swift
//  IOSUnLockGesturesView
//
//  Created by 乔晓松 on 2018/3/19.
//  Copyright © 2018年 coolspan. All rights reserved.
//

import UIKit

class PointView: UIView {
    
    private var outLayer: CAShapeLayer!
    private var centerDotLayer: CAShapeLayer!
    
    var ID: Int!
    var isSelected: Bool = false {
        didSet {
            if isSelected {
                centerDotLayer.isHidden = false
                outLayer.strokeColor = UIColor.purple.cgColor
            } else {
                centerDotLayer.isHidden = true
                outLayer.strokeColor = UIColor.gray.cgColor
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
        print("PointView:\(frame)")
        addCenterDotLayer()
        addUnSelectedOutLayer()

    }
    
    func addCenterDotLayer() {
        centerDotLayer = CAShapeLayer()
        centerDotLayer.isHidden = true
        let path = UIBezierPath.init(arcCenter: CGPoint(x: frame.size.width / 2, y: frame.size.height / 2), radius: (frame.size.width - 2.5) / 2 / 3, startAngle: 0, endAngle: CGFloat(2 * M_PI), clockwise: false)
        centerDotLayer.path = path.cgPath
        centerDotLayer.backgroundColor = UIColor.clear.cgColor
        centerDotLayer.fillColor = UIColor.green.cgColor
        centerDotLayer.strokeColor = UIColor.clear.cgColor
        centerDotLayer.lineWidth = 2.5
        centerDotLayer.frame = CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height)
//        layer.insertSublayer(centerDotLayer, at: 1)
        layer.addSublayer(centerDotLayer)
    }
    
    func addUnSelectedOutLayer() {
        outLayer = CAShapeLayer()
        let path = UIBezierPath.init(arcCenter: CGPoint(x: frame.size.width / 2, y: frame.size.height / 2), radius: (frame.size.width - 2.5) / 2, startAngle: 0, endAngle: CGFloat(2 * M_PI), clockwise: false)
        outLayer.path = path.cgPath
        outLayer.backgroundColor = UIColor.clear.cgColor
        outLayer.fillColor = UIColor.clear.cgColor
        outLayer.strokeColor = UIColor.gray.cgColor
        outLayer.lineWidth = 2.5
        outLayer.frame = CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height)
//        layer.insertSublayer(outLayer, at: 0)
        layer.addSublayer(outLayer)
    }
}
