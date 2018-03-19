//
//  GesturesViewController.swift
//  IOSUnLockGesturesView
//
//  Created by 乔晓松 on 2018/3/19.
//  Copyright © 2018年 coolspan. All rights reserved.
//

import UIKit

class GesturesViewController: UIViewController {
    
    var gesturesView: GesturesView!

    override func viewDidLoad() {
        super.viewDidLoad()

        initSubviews()
        
    }
    
}

// MARK: - private methods
extension GesturesViewController {
    
    func initSubviews() {
        view.backgroundColor = UIColor.white
        
        let width = UIScreen.main.bounds.width - 64 * 2
        gesturesView = GesturesView(frame: CGRect(x: 64, y: UIScreen.main.bounds.height - width - 128, width: width, height: width))
//        gesturesView.backgroundColor = UIColor.green
        self.view.addSubview(gesturesView)
        
    }
}
