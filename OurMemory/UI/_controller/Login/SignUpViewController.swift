//
//  SignUpViewControllerViewController.swift
//  OurMemory
//
//  Created by 이승기 on 2021/05/04.
//

import UIKit

enum CHECKIMGNAME {
    static let checkedBtnImgName = "checkmark.square"
    static let unCheckedBtnImgName = "square"
}

enum SIGNUPVIEWCASE {
    case SUCCESS
    case FAILE
    case CANCEL
}

class SignUpViewController: BaseViewController {

    @IBOutlet weak var signUpView: UIView!
    @IBOutlet weak var signUpNickNameTF: UITextField!
    @IBOutlet weak var signUpBirthdayTF: UITextField!
    @IBOutlet weak var signUpSolarCheckBtn: UIButton!
    @IBOutlet weak var signUpLunarCheckBtn: UIButton!
    @IBOutlet weak var signUpSwitchBtn: UISwitch!
    
    @IBOutlet weak var signUpConfirmBtn: UIButton!
    @IBOutlet weak var signUpCancelBtn: UIButton!
 
    var selectedSnsType:SNSTYPE?
    var loginCallback:((SIGNUPVIEWCASE) -> Void)!
    
    let sharedUserDataModel:SharedUserDataModel = SharedUserDataModel.sharedUserData
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.signUpSolarCheckBtn.isSelected = true
        self.signUpLunarCheckBtn.isSelected = false
        self.signUpSwitchBtn.isOn = true
        // Do any additional setup after loading the view.
    }
    
    func initWithCallBack(snsType:SNSTYPE,callback: @escaping (SIGNUPVIEWCASE) -> Void) {
        self.selectedSnsType = snsType
        self.loginCallback = callback
    }
    
    func changeCheckedImg() {
        if #available(iOS 13, *)
        {
            
            if self.signUpSolarCheckBtn.isSelected {
                self.signUpSolarCheckBtn.setImage(UIImage.init(systemName: CHECKIMGNAME.checkedBtnImgName), for: UIControl.State.normal)
                self.signUpLunarCheckBtn.setImage(UIImage.init(systemName: CHECKIMGNAME.unCheckedBtnImgName), for: UIControl.State.normal)
            }else {
                self.signUpSolarCheckBtn.setImage(UIImage.init(systemName: CHECKIMGNAME.unCheckedBtnImgName), for: UIControl.State.normal)
                self.signUpLunarCheckBtn.setImage(UIImage.init(systemName: CHECKIMGNAME.checkedBtnImgName), for: UIControl.State.normal)
            }
            
        }
    }
    
    @IBAction func clickedCheckBtn(_ sender: UIButton) {
        if sender == self.signUpSolarCheckBtn {
            self.signUpSolarCheckBtn.isSelected = true
            self.signUpLunarCheckBtn.isSelected = false
        }else {
            self.signUpSolarCheckBtn.isSelected = false
            self.signUpLunarCheckBtn.isSelected = true
        }
        
        self.changeCheckedImg()
    }
    
    
    @IBAction func clickedConfirmBtn(_ sender: UIButton) {
        if let nickname = self.signUpNickNameTF.text, nickname.count < 1 {
            return
        }
        
        if let birthday = self.signUpBirthdayTF.text, birthday.count < 1 {
            return
        }
        
        if let nickname = self.signUpNickNameTF.text,let birthday = self.signUpBirthdayTF.text,let snsType = self.selectedSnsType
        {
            KaKaoLoginWrapper.shared.setUserData(name: nickname, birthday: birthday, isSolar: self.signUpSolarCheckBtn.isSelected, isBirthdayOpen: self.signUpSwitchBtn.isOn,snsType: snsType){
                self.dismiss(animated: true, completion: nil)
                self.loginCallback(.SUCCESS)
            }
            
        }else {
            self.loginCallback(.FAILE)
        }
    }
    
    @IBAction func clickedCancelBtn(_ sender: UIButton) {
        KaKaoLoginWrapper.shared.dissConnectionKakao { flag in
            if flag {
                self.sharedUserDataModel.clearData()
            }
        }
        self.dismiss(animated: true, completion: nil)
        self.loginCallback(.CANCEL)
    }

    @IBAction func clickedSwitch(_ sender: UISwitch) {
        
    }
}
