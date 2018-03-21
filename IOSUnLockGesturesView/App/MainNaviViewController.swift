//
//  MainNaviViewController.swift
//  IOSUnLockGesturesView
//
//  Created by 乔晓松 on 2018/3/21.
//  Copyright © 2018年 coolspan. All rights reserved.
//

import UIKit

class MainNaviViewController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.interactivePopGestureRecognizer?.delegate = self
    }
    
}

//MARK:- UIGestureRecognizerDelegate methods
extension MainNaviViewController : UIGestureRecognizerDelegate {
    
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}
