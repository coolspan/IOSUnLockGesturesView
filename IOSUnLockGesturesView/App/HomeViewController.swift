//
//  HomeViewController.swift
//  IOSUnLockGesturesView
//
//  Created by 乔晓松 on 2018/3/19.
//  Copyright © 2018年 coolspan. All rights reserved.
//

import UIKit
import SnapKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        initSubviews()
        
    }

}

// MARK: - private methods
private extension HomeViewController {
    
    func initSubviews() {
        
        let settingGestureButton = UIButton()
        settingGestureButton.setTitle("设置手势密码", for: .normal)
        settingGestureButton.backgroundColor = UIColor.purple
        settingGestureButton.layer.cornerRadius = 8
        settingGestureButton.addTarget(self, action: #selector(onSettingGesturesAction), for: .touchUpInside)
        self.view.addSubview(settingGestureButton)
        settingGestureButton.snp.makeConstraints { (make) in
            make.width.equalTo(150)
            make.height.equalTo(60)
            make.left.equalTo(8)
            make.top.equalTo(60)
        }
        
        
    }
    
    @objc func onSettingGesturesAction() {
        let gesturesViewController = GesturesViewController()
        self.navigationController?.pushViewController(gesturesViewController, animated: true)
    }
}
