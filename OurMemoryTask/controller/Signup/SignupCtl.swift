//
//  signupCtl.swift
//  OurMemoryTask
//
//  Created by 이승기 on 2022/01/16.
//

import UIKit

class SignupCtl: BaseCtl {
    
    let signupModel:SignupModel = SignupModel()
    let dateModel:DateComponentsModel = DateComponentsModel()
    var datePickerAdapter:BaseDatePickerAdapter = BaseDatePickerAdapter()
    let sharedUserDataModel:SharedUserDataModel = SharedUserDataModel.sharedUserData
    
    override func __initWithData__(data: Any?) {
        signupModel.initWithData(data:data) { p1, p2 in
            switch p1 {
            case .SIGNUP_VALIDCHACK:
                guard let state:Bool = p2 as? Bool else {return}
                self.callUpdateConfirmBtnState(state: state)
                break
            case .SIGNUP_SUCCESS:
                self.callShowNextVC(view: NEXTVIEW.NEXTVIEW_MAIN, data: nil)
                break
            case .SIGNUP_UPDATENAME:
                self.callUpdateName(name: p2 as! String)
                break
            case .SIGNUP_UPDATEBIRTHDAY:
                self.dateModel.setDateStrForDateFormatStr(dateStr: p2 as! String, dateformatStr: "MMDD")
                break
            case .SIGNUP_UPDATEBIRTHDAYOPEN:
                self.callUpdateBirthdayOpenBtn(isOpenBirthday: p2 as! Bool)
                break
            case .SIGNUP_UPDATEDATEPICKER:
                let componentType = p2 as! COMPONENT_TYPE
                switch componentType {
                case .MONTH:
                    if let month = self.dateModel.components.month {
                        self.datePickerAdapter.selectComponentofRow(selectToComponent: componentType, row: month-1)
                    }
                    break
                case .DAY:
                    if let day = self.dateModel.components.day {
                        self.datePickerAdapter.selectComponentofRow(selectToComponent: componentType, row: day-1)
                    }
                    break
                default:
                    break
                }
                
                
                break
            case .SIGNUP_UPDATESOLAR:
                self.callUpdateSolarBtn(isSolar: p2 as! Bool)
                break
            case .DISCONNECT_SNS:
                self.callShowNextVC(view: NEXTVIEW.NEXTVIEW_POP, data: nil)
                break
            }
        }
        
        dateModel.initWithCallback { p1, p2 in
            switch p1 {
            default:
                break
            }
        }
        
    }

    //MARK: Private
    
    fileprivate func callUpdateName(name:String) {
        if let view = self.view as? SignupView {
            view.updateName(name: name)
        }
    }
    
    fileprivate func callSelectPickerSelectComponentOfRow(component:COMPONENT_TYPE,row:Int) {
        self.datePickerAdapter.selectComponentofRow(selectToComponent: component, row: row)
    }
    
    fileprivate func callUpdateConfirmBtnState(state:Bool) {
        if let view = self.view as? SignupView {
            view.updateConfirmBtnState(state: state)
        }
    }
    
    fileprivate func callUpdateResultAlert(user:userData) {
        if let view = self.view as? SignupView {
            view.updateResultAlert(user: user)
        }
    }

    fileprivate func callUpdateSolarBtn(isSolar:Bool) {
        if let view = view as? SignupView {
            view.updateSolarBtn(isSolar: isSolar)
        }
    }
    
    fileprivate func callUpdateBirthdayOpenBtn(isOpenBirthday:Bool) {
        if let view = view as? SignupView {
            view.updateBirthdayOpenBtn(isOpenBirthday: isOpenBirthday)
        }
    }
    
}

extension SignupCtl:SignupContract {
    
    //MARK: SignupContract
    
    func setName(name: String) {
        self.signupModel.setName(name: name)
    }
    
    func setDatePickerWithAdpater(datePicker:UIPickerView) {
        
        self.datePickerAdapter.setPickerController(pickerView: datePicker, pickerViewMode:PICKER_MODE.MM_DD) { p1,p2 in
            let result:RESULT_DATE = RESULT_DATE.init(rawValue: p1)!
            switch result {
            case .RESULT_MONTH:
                self.dateModel.setMonth(month: p2 as! Int)
                self.signupModel.setSelectMonth(month: self.dateModel.getDateWithDateformat(dateformatStr: "mm"))
                break
            case .RESULT_DAY:
                self.dateModel.setDay(day: p2 as! Int)
                self.signupModel.setSelectDay(day: self.dateModel.getDateWithDateformat(dateformatStr: "dd"))
                break
            default:
                break
            }
        }
    }
    
    
    func actionCancelBtn(sender: UIButton) {
        signupModel.disconnectSnsLogin()
    }
    
    func actionConfirmBtn(sender: UIButton) {
        signupModel.trySignupRequest(context: self)
    }
    
    func actionBirthdayOpenBtn(sender: UIButton) {
        signupModel.setBirthdayOpenState(state: true)
    }
    
    func actionBirthdayCloseBtn(sender: UIButton) {
        signupModel.setBirthdayOpenState(state: false)
    }
    
    func actionSolarBtn(sender: UIButton) {
        signupModel.setSolar(solar: true)
    }
    
    func actionLunarBtn(sender: UIButton) {
        signupModel.setSolar(solar: false)
    }
    
    func disconnectSnsLogin() {
        signupModel.disconnectSnsLogin()
    }
    
    func setBirthdayOpenState(state:Bool) {
        signupModel.setBirthdayOpenState(state: state)
    }
    
    
    
}
