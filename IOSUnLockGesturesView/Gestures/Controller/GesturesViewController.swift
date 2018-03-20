//
//  GesturesViewController.swift
//  IOSUnLockGesturesView
//
//  Created by 乔晓松 on 2018/3/19.
//  Copyright © 2018年 coolspan. All rights reserved.
//

import UIKit
import LCProgressHUD

class GesturesViewController: UIViewController {
    
    var gesturesView: GesturesView!
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
extension GesturesViewController {
    
    func initSubviews() {
        view.backgroundColor = UIColor.init(red: 17 / 255, green: 18 / 255, blue: 19 / 255, alpha: 1)
        let whiteView = UIView()
        whiteView.backgroundColor = UIColor.init(red: 1, green: 1, blue: 1, alpha: 0.1)
        view.addSubview(whiteView)
        whiteView.snp.makeConstraints { (make) in
            make.width.height.left.top.equalToSuperview()
        }
        
        let width: CGFloat = UIScreen.main.bounds.width - 64 * 2
        gesturesView = GesturesView(frame: CGRect(x: 64, y: (UIScreen.main.bounds.height - width) / 2, width: width, height: width + 100))
        gesturesView.isSettingGestures = isSettingGestures
        
        if isSettingGestures {
            titleLabel.text = "请设置密码"
            gesturesView.settingSuccessBlock = { keyword in
                if self.keyword == "" {
                    self.titleLabel.text = "请再次设置密码"
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
                            self?.titleLabel.text = "请设置密码"
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
                    self.titleLabel.text = "请设置密码"
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
        
        titleLabel.textColor = UIColor.white
        self.view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(CGFloat(((UIScreen.main.bounds.height - width) / 2)) - 60)
        }
    }
}
