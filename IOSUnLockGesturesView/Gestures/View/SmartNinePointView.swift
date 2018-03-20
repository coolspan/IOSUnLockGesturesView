//
//  SmartNinePointView.swift
//  IOSUnLockGesturesView
//
//  Created by 乔晓松 on 2018/3/20.
//  Copyright © 2018年 coolspan. All rights reserved.
//

import UIKit

class SmartNinePointView: UIView {
    
    private var pointsLayer: [CAShapeLayer]!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// MARK: - private methods
private extension SmartNinePointView {
    
    func initSubviews() {
        print("frame:\(frame)")
        pointsLayer = [CAShapeLayer]()
        let drawWidth: CGFloat = min(frame.size.width, frame.size.height)
        let dotWidth: CGFloat = 8
        for index in 0 ..< 9 {
            let dotLayer = CAShapeLayer()
            let x: CGFloat = ((drawWidth - 3 * dotWidth) / 2 + dotWidth) * CGFloat(index % 3)
            let y: CGFloat = ((drawWidth - 3 * dotWidth) / 2 + dotWidth) * CGFloat(index / 3)
            dotLayer.backgroundColor = UIColor.init(red: 101 / 255, green: 101 / 255, blue: 101 / 255, alpha: 1).cgColor
            dotLayer.fillColor = UIColor.clear.cgColor
            dotLayer.strokeColor = UIColor.clear.cgColor
            dotLayer.lineWidth = 1
            dotLayer.cornerRadius = dotWidth / 2.0
            dotLayer.frame = CGRect(x: x, y: y, width: dotWidth, height: dotWidth)
            layer.addSublayer(dotLayer)
            pointsLayer.append(dotLayer)
        }
    }
}

// MARK: - public methods
extension SmartNinePointView {
    
    func update(keyword: String) {
        for key in keyword {
            let num: Int = key.toInt() - 48
            print("num:\(num)")
            if num >= 0 && num < pointsLayer.count {
                let dotLayer = pointsLayer[num]
                dotLayer.backgroundColor = UIColor.init(red: 22 / 255, green: 178 / 255, blue: 253 / 255, alpha: 1).cgColor
                dotLayer.strokeColor = UIColor.clear.cgColor
            }
        }
    }
    
    func clearColor() {
        for layer in pointsLayer {
            layer.backgroundColor = UIColor.init(red: 101 / 255, green: 101 / 255, blue: 101 / 255, alpha: 1).cgColor
            layer.strokeColor = UIColor.clear.cgColor
        }
    }
}

extension Character{
    
    func toInt() -> Int{
        var intFromCharacter:Int = 0
        for scalar in String(self).unicodeScalars{
            intFromCharacter = Int(scalar.value)
        }
        return intFromCharacter
    }
}
