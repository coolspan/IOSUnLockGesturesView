//
//  GesturesView.swift
//  IOSUnLockGesturesView
//
//  Created by 乔晓松 on 2018/3/19.
//  Copyright © 2018年 coolspan. All rights reserved.
//

import UIKit

class GesturesView: UIView {
    
    /// 绘制区域的宽度和高度，取宽度和高度较小值
    private var drawWidth: CGFloat!
    
    private var touchEnd = false
    
    private var pointViews = [PointView]()
    private var startPoint: CGPoint!
    private var endPoint: CGPoint!
    
    private var selectedViewCenter = NSMutableArray.init()
    private var selectedView = NSMutableArray.init()
    
    private var lineLayer: CAShapeLayer!
    private var linePath: UIBezierPath!
    
    private var blacksLayer: CAShapeLayer!
    
    var isSettingGestures = false
    
    var isSuccessRestoreStyle = true
    
    var settingSuccessBlock: ((_ keyword: String) -> Void)?
    var settingErrorBlock: (() -> Void)?
    var unlockBlock: ((_ isSuccess: Bool) -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        lineLayer = CAShapeLayer()
        linePath = UIBezierPath()
        
        startPoint = CGPoint.zero
        endPoint = CGPoint.zero
        
        initSubviews(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// MARK: - private methods
private extension GesturesView {
    
    func initSubviews(frame: CGRect) {
        
        drawWidth = min(frame.size.width, frame.size.height)
        
        blacksLayer = CAShapeLayer()
        blacksLayer.frame = CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height)
        layer.insertSublayer(blacksLayer, at: 0)
        
        let pointWidth: CGFloat = 60
        for index in 0 ..< 9 {
            let blackLayer = CAShapeLayer()
            let x: CGFloat = ((drawWidth - 3 * pointWidth) / 2 + pointWidth ) * CGFloat(index % 3)
            let y: CGFloat = ((drawWidth - 3 * pointWidth) / 2 + pointWidth ) * CGFloat(index / 3)
            let path = UIBezierPath.init(arcCenter: CGPoint(x: pointWidth / 2 , y: pointWidth / 2), radius: (pointWidth - 5) / 2, startAngle: 0, endAngle: CGFloat(2 * Double.pi), clockwise: false)
            blackLayer.path = path.cgPath
            blackLayer.backgroundColor = UIColor.clear.cgColor
            blackLayer.fillColor = UIColor.init(red: 17 / 255, green: 18 / 255, blue: 19 / 255, alpha: 1).cgColor
            blackLayer.strokeColor = UIColor.clear.cgColor
            blackLayer.lineWidth = 2.5
            blackLayer.frame = CGRect(x: x, y: y, width: pointWidth, height: pointWidth)
            blacksLayer.addSublayer(blackLayer)
        }
        
        for index in 0 ..< 9 {
            let x: CGFloat = ((drawWidth - 3 * pointWidth) / 2 + pointWidth ) * CGFloat(index % 3)
            let y: CGFloat = ((drawWidth - 3 * pointWidth) / 2 + pointWidth ) * CGFloat(index / 3)
            let pointView = PointView(frame: CGRect(x: x, y: y, width: pointWidth, height: pointWidth), id: index)
            pointViews.append(pointView)
            addSubview(pointView)
        }
    }
}

// MARK: - touch methods
extension GesturesView {
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let point: CGPoint = (touches.first?.location(in: self))!
        for pointView in pointViews {
            if pointView.frame.contains(point) {
                if CGPoint.zero.equalTo(self.startPoint) {
                    self.startPoint = pointView.center
                }
                
                if !selectedViewCenter.contains(NSValue.init(cgPoint: pointView.center)) {
                    selectedViewCenter.add(NSValue.init(cgPoint: pointView.center))
                }
                
                if !selectedView.contains(pointView.ID) {
                    selectedView.add(pointView.ID)
                    pointView.isSelected = true
                }
            }
        }
        if !CGPoint.zero.equalTo(self.startPoint) {
            self.endPoint = point
            drawLines()
        }
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        guard let endPoint = self.selectedViewCenter.lastObject else {
            return
        }
        
        self.endPoint = endPoint as! CGPoint
        
        if CGPoint.zero.equalTo(self.endPoint) {
            return
        }
        
        drawLines()
        
        touchEnd = true
        
        if isSettingGestures {
            if selectedView.count < 4 {
                styleError()
                if let callback = settingErrorBlock {
                    callback()
                }
            } else {
                styleSuccess()
                var keyword = ""
                for key in selectedView {
                    keyword.append("\(key)")
                }
                if let callback = settingSuccessBlock {
                    callback(keyword)
                }
            }
        } else {
            var keyword = ""
            for key in selectedView {
                keyword.append("\(key)")
            }
            let gestureUnlock: String = UserDefaults.standard.string(forKey: "GestureUnlock")!
            //解锁成功
            if keyword == gestureUnlock {
                styleSuccess()
                if let callback = unlockBlock {
                    callback(true)
                }
            } else {//解锁失败
                styleError()
                if let callback = unlockBlock {
                    callback(false)
                }
            }
        }
    }
    
    func resoreStyle(_ time: DispatchTime) {
        DispatchQueue.main.asyncAfter(deadline: time) { [weak self] in
            UIView.beginAnimations(nil, context: nil)
            UIView.setAnimationDuration(0.3)
            self?.lineLayer.removeFromSuperlayer()
            self?.linePath.removeAllPoints()
            for pointView in (self?.pointViews)! {
                pointView.isSuccess = false
                pointView.isError = false
                pointView.isSelected = false
            }
            self?.selectedViewCenter.removeAllObjects()
            self?.selectedView.removeAllObjects()
            self?.startPoint = CGPoint.zero
            self?.endPoint = CGPoint.zero
            UIView.commitAnimations()
        }
    }
    
    func styleSuccess() {
        for pointView in pointViews {
            pointView.isSuccess = true
        }
        lineLayer.strokeColor = UIColor.green.cgColor
        
        if !isSuccessRestoreStyle {
            return
        }
        
        resoreStyle(DispatchTime.now() + 0.2)
        
    }
    
    func styleError() {
        for pointView in pointViews {
            pointView.isError = true
        }
        lineLayer.strokeColor = UIColor.red.cgColor
        layer.addSublayer(lineLayer)
        resoreStyle(DispatchTime.now() + 0.5)
    }
    
    func drawLines() {
        
        lineLayer.removeFromSuperlayer()
        linePath.removeAllPoints()
        
        linePath.move(to: startPoint)
        for point in selectedViewCenter {
            linePath.addLine(to: point as! CGPoint)
        }
        linePath.addLine(to: endPoint)
        
        lineLayer.path = linePath.cgPath
        lineLayer.lineWidth = 4.0
        lineLayer.strokeColor = UIColor.init(red: 22 / 255, green: 178 / 255, blue: 253 / 255, alpha: 1).cgColor
        lineLayer.fillColor = UIColor.clear.cgColor
        lineLayer.lineJoin = kCALineJoinRound
        layer.insertSublayer(lineLayer, above: blacksLayer)
        
        layer.masksToBounds = true
        
    }
}
