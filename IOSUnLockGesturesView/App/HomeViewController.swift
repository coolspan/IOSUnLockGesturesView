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
    
    /// QQ安全中心
    private var qqSafeTitleLabel: UILabel!
    private var qqSafeSettingGestureButton: UIButton!
    private var qqSafeUnlockButton: UIButton!
    
    /// QQ
    private var qqTitleLabel: UILabel!
    private var qqSettingGestureButton: UIButton!
    private var qqUnlockButton: UIButton!
    
    /// 操作
    private var clearPasswordButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initSubviews()
        
    }
    
}

// MARK: - private methods
private extension HomeViewController {
    
    func initSubviews() {
        
        qqSafeTitleLabel = UILabel()
        qqSafeTitleLabel.textColor = UIColor.black
        qqSafeTitleLabel.font = UIFont.systemFont(ofSize: 24)
        qqSafeTitleLabel.text = "QQ安全中心"
        view.addSubview(qqSafeTitleLabel)
        qqSafeTitleLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(UIApplication.shared.statusBarFrame.height + 16)
        }
        
        qqSafeSettingGestureButton = UIButton()
        qqSafeSettingGestureButton.setTitle("设置手势密码", for: .normal)
        qqSafeSettingGestureButton.backgroundColor = UIColor.purple
        qqSafeSettingGestureButton.layer.cornerRadius = 8
        qqSafeSettingGestureButton.addTarget(self, action: #selector(onClickAction(button:)), for: .touchUpInside)
        self.view.addSubview(qqSafeSettingGestureButton)
        qqSafeSettingGestureButton.snp.makeConstraints { (make) in
            make.width.equalTo(150)
            make.height.equalTo(60)
            make.top.equalTo(qqSafeTitleLabel.snp.bottom).offset(16)
            make.centerX.equalToSuperview().offset(-83)
        }
        
        qqSafeUnlockButton = UIButton()
        qqSafeUnlockButton.setTitle("解锁🔓", for: .normal)
        qqSafeUnlockButton.backgroundColor = UIColor.purple
        qqSafeUnlockButton.layer.cornerRadius = 8
        qqSafeUnlockButton.addTarget(self, action: #selector(onClickAction(button:)), for: .touchUpInside)
        self.view.addSubview(qqSafeUnlockButton)
        qqSafeUnlockButton.snp.makeConstraints { (make) in
            make.width.equalTo(150)
            make.height.equalTo(60)
            make.centerY.equalTo(qqSafeSettingGestureButton)
            make.centerX.equalToSuperview().offset(83)
        }
        
        qqTitleLabel = UILabel()
        qqTitleLabel.textColor = UIColor.black
        qqTitleLabel.font = UIFont.systemFont(ofSize: 24)
        qqTitleLabel.text = "QQ"
        view.addSubview(qqTitleLabel)
        qqTitleLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(qqSafeSettingGestureButton.snp.bottom).offset(24)
        }
        
        qqSettingGestureButton = UIButton()
        qqSettingGestureButton.setTitle("设置手势密码", for: .normal)
        qqSettingGestureButton.backgroundColor = UIColor.purple
        qqSettingGestureButton.layer.cornerRadius = 8
        qqSettingGestureButton.addTarget(self, action: #selector(onClickAction(button:)), for: .touchUpInside)
        self.view.addSubview(qqSettingGestureButton)
        qqSettingGestureButton.snp.makeConstraints { (make) in
            make.width.equalTo(150)
            make.height.equalTo(60)
            make.top.equalTo(qqTitleLabel.snp.bottom).offset(16)
            make.centerX.equalToSuperview().offset(-83)
        }
        
        qqUnlockButton = UIButton()
        qqUnlockButton.setTitle("解锁🔓", for: .normal)
        qqUnlockButton.backgroundColor = UIColor.purple
        qqUnlockButton.layer.cornerRadius = 8
        qqUnlockButton.addTarget(self, action: #selector(onClickAction(button:)), for: .touchUpInside)
        self.view.addSubview(qqUnlockButton)
        qqUnlockButton.snp.makeConstraints { (make) in
            make.width.equalTo(150)
            make.height.equalTo(60)
            make.centerY.equalTo(qqSettingGestureButton)
            make.centerX.equalToSuperview().offset(83)
        }
        
        clearPasswordButton = UIButton()
        clearPasswordButton.setTitle("清除手势密码", for: .normal)
        clearPasswordButton.backgroundColor = UIColor.purple
        clearPasswordButton.layer.cornerRadius = 8
        clearPasswordButton.addTarget(self, action: #selector(onClickAction(button:)), for: .touchUpInside)
        self.view.addSubview(clearPasswordButton)
        clearPasswordButton.snp.makeConstraints { (make) in
            make.width.equalTo(150)
            make.height.equalTo(60)
            make.centerX.equalToSuperview()
            make.top.equalTo(qqUnlockButton.snp.bottom).offset(32)
        }
        
        let ninePointView = SmartNinePointView(frame: CGRect(x: CGFloat((UIScreen.main.bounds.width - 40) / 2), y: CGFloat(UIScreen.main.bounds.height - 80), width: 40, height: 40))
        self.view.addSubview(ninePointView)
        let keyword = UserDefaults.standard.string(forKey: "GestureUnlock")
        if keyword != nil {
            ninePointView.update(keyword: keyword!)
        }
    }
    
    @objc func onClickAction(button: UIButton) {
        if button == qqSafeSettingGestureButton {
            let gesturesViewController = GesturesViewController()
            gesturesViewController.isSettingGestures = true
            self.navigationController?.pushViewController(gesturesViewController, animated: true)
        } else if button == qqSafeUnlockButton {
            let keyword = UserDefaults.standard.string(forKey: "GestureUnlock")
            if keyword == nil {
                LCProgressHUD.showInfoMsg("请先设置手势密码")
            } else {
                let gesturesViewController = GesturesViewController()
                gesturesViewController.isSettingGestures = false
                self.navigationController?.pushViewController(gesturesViewController, animated: true)
            }
        } else if button == qqSettingGestureButton {
            let gesturesViewController = QQGesturesViewController()
            gesturesViewController.isSettingGestures = true
            self.navigationController?.pushViewController(gesturesViewController, animated: true)
        } else if button == qqUnlockButton {
            let keyword = UserDefaults.standard.string(forKey: "GestureUnlock")
            if keyword == nil {
                LCProgressHUD.showInfoMsg("请先设置手势密码")
            } else {
                let gesturesViewController = QQGesturesViewController()
                gesturesViewController.isSettingGestures = false
                self.navigationController?.pushViewController(gesturesViewController, animated: true)
            }
        } else if button == clearPasswordButton {
            UserDefaults.standard.removeObject(forKey: "GestureUnlock")
            LCProgressHUD.showSuccess("清除手势密码成功")
        }
    }
}
