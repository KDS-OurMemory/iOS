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
    
    @IBOutlet weak var signUpDatePicker: UIPickerView!
    
    @IBOutlet weak var signUpIsSolarBtn: UIButton!
    @IBOutlet weak var signUpIsLunarBtn: UIButton!
    
    @IBOutlet weak var signUpBirthdayIsOpenBtn: UIButton!
    @IBOutlet weak var signUpBirthdayIsCloseBtn: UIButton!
    
    @IBOutlet weak var signUpConfirmBtn: UIButton!
    @IBOutlet weak var signUpCancelBtn: UIButton!
    
    var signupCtl:SignupContract?
    var loginCallback:((SIGNUPVIEWCASE) -> Void)!
    var selectedMonthDays:Int = 30
    var resultAlertConfrimBtnCallback:(() -> Void)!
    var resultAlertCancelBtnCallback:(() -> Void)!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        signUpDatePicker.delegate = self
        signUpDatePicker.dataSource = self
    }
    
    override func getDataContract() -> DataContract? {
        return self.signupCtl
    }
    
    override func prepareViewWithData(data: Any?) {
        if self.getDataContract() == nil {
            signupCtl = (CtlMaker().createDataControllerWithContract(contract: ctls.eContractSignup, view: self,data: data) as? SignupContract)
            if let ctl = self.getDataContract() as? SignupContract {
                ctl.setDatePickerWithAdpater(datePicker: signUpDatePicker)
            }
            
            signUpConfirmBtn.alpha = 0.8
            if let signupCtl = signupCtl {
                
                signUpIsSolarBtn.addAction { p1 in
                    signupCtl.actionSolarBtn(sender: p1 as! UIButton)
                }
                
                signUpIsLunarBtn.addAction { p1 in
                    signupCtl.actionLunarBtn(sender: p1 as! UIButton)
                }
                
                signUpBirthdayIsOpenBtn.addAction { p1 in
                    signupCtl.actionBirthdayOpenBtn(sender: p1 as! UIButton)
                }
                
                signUpBirthdayIsCloseBtn.addAction { p1 in
                    signupCtl.actionBirthdayCloseBtn(sender: p1 as! UIButton)
                }
                
                signUpConfirmBtn.addAction { p1 in
                    signupCtl.actionConfirmBtn(sender: p1 as! UIButton)
                }
                
                signUpCancelBtn.addAction { p1 in
                    signupCtl.actionCancelBtn(sender: p1 as! UIButton)
                }
                
                
            }
            
            signUpNickNameTF.delegate = self
            
        }
    }
    
    func updateSelectedRow(month:Int, day:Int) {
        signUpDatePicker.selectRow(month, inComponent: 0, animated: true)
        signUpDatePicker.selectRow(day, inComponent: 1, animated: true)
    }
    
    func updateSelectedDatePickerMonthDayCnt(days:Int) {
        selectedMonthDays = days
    }
    
    override func showNextVC(vc: NEXTVIEW, data: Any?) {
        switch vc {
        case .NEXTVIEW_POP:
            self.navigate(NEXTVIEW.NEXTVIEW_POP, data: nil)
            break
        case .NEXTVIEW_MAIN:
            self.navigate(NEXTVIEW.NEXTVIEW_MAIN, data: data)
            break
        default:
            break
        }
    }
    
}


extension SignUpViewController:SignupView {
    
    func updateName(name: String) {
        signUpNickNameTF.text = name
    }
    
    func updateBirthday(birthday: String) {
//        signUpDatePicker.se
    }
    
    func updateSolarBtn(isSolar: Bool) {
        signUpIsSolarBtn.backgroundColor = (isSolar ? UIColor.blue:UIColor.gray)
        signUpIsLunarBtn.backgroundColor = (isSolar ? UIColor.gray:UIColor.blue)
    }
    
    func updateBirthdayOpenBtn(isOpenBirthday: Bool) {
        signUpBirthdayIsOpenBtn.backgroundColor = (isOpenBirthday ? UIColor.blue:UIColor.gray)
        signUpBirthdayIsCloseBtn.backgroundColor = (isOpenBirthday ? UIColor.gray:UIColor.blue)
    }
    
    // MARK: SignupViewContract
    
    func updateConfirmBtnState(state:Bool) {
        signUpConfirmBtn.isEnabled = state
        signUpConfirmBtn.alpha = (state == true ? 1.0:0.8)
        
    }
    
    func updateResultAlert(user:userData) {
        self.showAlertMsgWithTitleAndActions(title: "추가 정보 확인", msg:""
                                             //                                   """
                                             //       이름:\(userData.getName())\n
                                             //       생일:\(userData.getBirthday)\n
                                             //       생일 타입:\(userData.getIsSolar)\n
                                             //       생일 공개 여부:\(userData.getBirthdayOpen)\n
                                             //"""
                                             ,actions: [
                                                "확인":{ _ in
                                                    self.showNextVC(vc: NEXTVIEW.NEXTVIEW_MAIN, data: nil)
                                                },
                                                "취소":{ _ in
                                                    
                                                }])
    }
}


extension SignUpViewController:UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let ctl = self.getDataContract() as? SignupContract, let text = textField.text {
            ctl.setName(name:text)
        }
    }
}
