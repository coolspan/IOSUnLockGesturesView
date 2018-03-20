//
//  HomeViewController.swift
//  IOSUnLockGesturesView
//
//  Created by 乔晓松 on 2018/3/19.
//  Copyright © 2018年 coolspan. All rights reserved.
//

import UIKit
import SnapKit
import LCProgressHUD

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
            make.centerX.equalToSuperview()
            make.top.equalTo(60)
        }
        
        let unlockButton = UIButton()
        unlockButton.setTitle("解锁🔓", for: .normal)
        unlockButton.backgroundColor = UIColor.purple
        unlockButton.layer.cornerRadius = 8
        unlockButton.addTarget(self, action: #selector(onUnlockAction), for: .touchUpInside)
        self.view.addSubview(unlockButton)
        unlockButton.snp.makeConstraints { (make) in
            make.width.equalTo(150)
            make.height.equalTo(60)
            make.centerX.equalToSuperview()
            make.top.equalTo(settingGestureButton.snp.bottom).offset(16)
        }
        
        let clearButton = UIButton()
        clearButton.setTitle("清除手势密码", for: .normal)
        clearButton.backgroundColor = UIColor.purple
        clearButton.layer.cornerRadius = 8
        clearButton.addTarget(self, action: #selector(onClearAction), for: .touchUpInside)
        self.view.addSubview(clearButton)
        clearButton.snp.makeConstraints { (make) in
            make.width.equalTo(150)
            make.height.equalTo(60)
            make.centerX.equalToSuperview()
            make.top.equalTo(unlockButton.snp.bottom).offset(16)
        }
        
        let ninePointView = SmartNinePointView(frame: CGRect(x: CGFloat((UIScreen.main.bounds.width - 40) / 2), y: CGFloat(UIScreen.main.bounds.height - 80), width: 40, height: 40))
        
        self.view.addSubview(ninePointView)
        let keyword = UserDefaults.standard.string(forKey: "GestureUnlock")
        if keyword != nil {
            ninePointView.update(keyword: keyword!)
        }
        
    }
    
    @objc func onClearAction() {
        UserDefaults.standard.removeObject(forKey: "GestureUnlock")
        LCProgressHUD.showSuccess("清除手势密码成功")
    }
    
    @objc func onUnlockAction() {
        let keyword = UserDefaults.standard.string(forKey: "GestureUnlock")
        if keyword == nil {
            LCProgressHUD.showInfoMsg("请先设置手势密码")
        } else {
            let gesturesViewController = GesturesViewController()
            gesturesViewController.isSettingGestures = false
            self.navigationController?.pushViewController(gesturesViewController, animated: true)
        }
    }
    
    @objc func onSettingGesturesAction() {
        let gesturesViewController = GesturesViewController()
        gesturesViewController.isSettingGestures = true
        self.navigationController?.pushViewController(gesturesViewController, animated: true)
    }
}
