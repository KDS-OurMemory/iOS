//
//  SignUpViewController+DatePicker.swift
//  OurMemory
//
//  Created by 이승기 on 2022/01/19.
//

import UIKit

extension SignUpViewController:UIPickerViewDelegate,UIPickerViewDataSource {
    
    enum PICKERVIEW_COMPONENT:Int {
        case MONTH_COMPONENT = 0
        case DAY_COMPONENT = 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        var rowInComponent:Int = 0
        switch component {
        case PICKERVIEW_COMPONENT.MONTH_COMPONENT.rawValue:
            rowInComponent = 12
            break
        case PICKERVIEW_COMPONENT.DAY_COMPONENT.rawValue:
            rowInComponent = selectedMonthDays
            break
        default:
            break
        }
        
        return rowInComponent
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(row+1)"
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch component {
        case PICKERVIEW_COMPONENT.MONTH_COMPONENT.rawValue:
            
            break
        case PICKERVIEW_COMPONENT.DAY_COMPONENT.rawValue:
            
            break
        default:
            break
        }
    }
}
