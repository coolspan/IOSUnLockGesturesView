//
//  QQGesturesViewController.swift
//  IOSUnLockGesturesView
//
//  Created by 乔晓松 on 2018/3/21.
//  Copyright © 2018年 coolspan. All rights reserved.
//

import UIKit
import LCProgressHUD

class QQGesturesViewController: UIViewController {

    var gesturesView: QQGesturesView!
    var ninePointView: SmartNinePointView!
    let titleLabel = UILabel()
    
    var isSettingGestures = false
    
    var keyword: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initSubviews()
        
    }
    
}

// MARK: - private methods
extension QQGesturesViewController {
    
    func initSubviews() {
        view.backgroundColor = UIColor.init(red: 245 / 255, green: 245 / 255, blue: 248 / 255, alpha: 1)
        
        let width: CGFloat = UIScreen.main.bounds.width - 64 * 2
        gesturesView = QQGesturesView(frame: CGRect(x: 64, y: (UIScreen.main.bounds.height - width) / 2, width: width, height: width + 100))
        gesturesView.isSettingGestures = isSettingGestures
        
        if isSettingGestures {
            titleLabel.text = "请设置解锁图案"
            gesturesView.settingSuccessBlock = { keyword in
                if self.keyword == "" {
                    self.titleLabel.text = "请再次设置解锁图案"
                    print("第一遍设置密码：\(keyword)")
                    self.keyword = keyword
                    self.gesturesView.isSuccessRestoreStyle = false
                    self.ninePointView.update(keyword: keyword)
                } else {
                    if self.keyword == keyword {
                        self.titleLabel.text = "设置密码成功"
                        print("第二遍设置密码：\(keyword)")
                        UserDefaults.standard.setValue(keyword, forKey: "GestureUnlock")
                        self.navigationController?.popViewController(animated: true)
                        LCProgressHUD.showSuccess("设置密码成功")
                    } else {
                        self.titleLabel.text = "两次密码不一致"
                        print("两次密码不一致：\(keyword)")
                        self.keyword = ""
                        self.gesturesView.isSuccessRestoreStyle = true
                        self.gesturesView.resoreStyle(DispatchTime.now() + 0.5)
                        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5) { [weak self] in
                            self?.ninePointView.clearColor()
                            self?.titleLabel.text = "请设置解锁图案"
                        }
                    }
                }
            }
            gesturesView.settingErrorBlock = {
                print("设置手势密码失败，密码不能少于四个点")
                if self.keyword != "" {
                    self.keyword = ""
                    self.gesturesView.isSuccessRestoreStyle = true
                    self.ninePointView.clearColor()
                    self.titleLabel.text = "请设置解锁图案"
                }
                LCProgressHUD.showFailure("密码不能少于四个点")
            }
        } else {
            titleLabel.text = "解锁"
            gesturesView.isSuccessRestoreStyle = false
            gesturesView.unlockBlock = { isSuccess in
                print("解锁：\(isSuccess)")
                if isSuccess {
                    self.titleLabel.text = "解锁成功"
                    self.navigationController?.popViewController(animated: true)
                    LCProgressHUD.showSuccess("解锁成功")
                } else {
                    self.titleLabel.text = "解锁失败，请重试"
                    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5) { [weak self] in
                        self?.titleLabel.text = "解锁"
                    }
                }
            }
        }
        self.view.addSubview(gesturesView)
        
        ninePointView = SmartNinePointView(frame: CGRect(x: CGFloat((UIScreen.main.bounds.width - 40) / 2), y: CGFloat(((UIScreen.main.bounds.height - width) / 2) - 120), width: 40, height: 40))
        self.view.addSubview(ninePointView)
        
        titleLabel.textColor = UIColor.black
        self.view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(CGFloat(((UIScreen.main.bounds.height - width) / 2)) - 60)
        }
    }
}
