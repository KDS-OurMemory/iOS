//
//  DatePickerViewController.swift
//  OurMemory
//
//  Created by 이승기 on 2021/04/05.
//

import UIKit

class SelectDateViewController: BaseViewController {
    
    @IBOutlet var datePicker: UIDatePicker!
    fileprivate var trySelectDateBlock:((String) -> Void)?
    
    func setSelectedDateBlock(block:@escaping (String) -> Void) {
        trySelectDateBlock = block
    }

}

extension SelectDateViewController: SelectDateView {
    func updateSelectedDateTitle(title: String) {
        
    }
    
    func updateSelectedDates(dates: [String]) {
        
    }
    
    
}
