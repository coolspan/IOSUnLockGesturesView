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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        let selectedView = NSMutableArray.init()
        selectedView.add(1)
        selectedView.add(4)
        selectedView.add(7)
        UserDefaults.standard.setValue(selectedView, forKey: "GestureUnlock")
        
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
        print("initSubviews:\(frame)")
        
        drawWidth = min(frame.size.width, frame.size.height)
        
        let pointWidth: CGFloat = 60
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
        print("touchesMoved")
        
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
        print("touchesEnded")
        
        self.endPoint = self.selectedViewCenter.lastObject as! CGPoint
        
        if CGPoint.zero.equalTo(self.endPoint) {
            return
        }
        
        drawLines()
        
        touchEnd = true
        
        let array: [Any] = UserDefaults.standard.array(forKey: "GestureUnlock")!
        
        //解锁成功
        if self.selectedView.isEqual(to: array) {
            for pointView in pointViews {
                pointView.isSuccess = true
            }
            lineLayer.strokeColor = UIColor.orange.cgColor
        } else {//解锁失败
            for pointView in pointViews {
                pointView.isError = true
            }
        }
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
        lineLayer.strokeColor = UIColor.red.cgColor
        lineLayer.fillColor = UIColor.clear.cgColor
        
//        layer.addSublayer(lineLayer)
        layer.insertSublayer(lineLayer, at: 0)
        
        layer.masksToBounds = true
        
    }
}
