//
//  DatePickerViewController.swift
//  OurMemory
//
//  Created by 이승기 on 2021/04/05.
//

import UIKit

class SelectDateViewController: BaseViewController {
    
    @IBOutlet weak var closeBtn: UIButton!
    @IBOutlet weak var confirmBtn: UIButton!
    @IBOutlet weak var datePicker: UIPickerView!
    @IBOutlet weak var selectedDateItemSv: UIScrollView!
    
    var selectDateCtl:SelectDateContract?
    let selectDatePickerAdapter:SelectDatePopDatePickerAdapter = SelectDatePopDatePickerAdapter()
    fileprivate var trySelectDateBlock:((ScheduleTimeDataBinder) -> Void)?

    override func viewWillAppear(_ animated: Bool) {
        self.setBackgroundDimColor()
    }
    
    override func getDataContract() -> DataContract? {
        return selectDateCtl
    }
    
    override func prepareViewWithData(data: Any?) {
        if self.getDataContract() == nil{
            selectDateCtl = CtlMaker().createDataControllerWithContract(contract: .eContractSelectDate, view: self, data: data) as? SelectDateContract
            if let ctl = self.getDataContract() as? SelectDateContract {
                closeBtn.addAction { p1 in
                    ctl.actionCancelBtn(sender: p1 as! UIButton)
                }
                
                confirmBtn.addAction { p1 in
                    ctl.actionConfirmBtn(sender: p1 as! UIButton)
                }
                
                ctl.setDatePickerWithAdpater(adapter: selectDatePickerAdapter, pickerView: datePicker)
            }
        }
    }

    
    func setSelectedDateBlock(block:@escaping (ScheduleTimeDataBinder) -> Void) {
        trySelectDateBlock = block
    }

}

extension SelectDateViewController: SelectDateView {
    func updateSelectedSchedulesData(selecteSchedule: ScheduleTimeDataBinder) {
        if let callback = trySelectDateBlock {
            callback(selecteSchedule)
        }
    }
    
    func updateSelectedSchedules(schedules: [ScheduleTimeDataBinder]) {
        
    }
    
    func updateSelectedDateConfirmBtnState(state: Bool) {
        confirmBtn.isEnabled = state
        confirmBtn.alpha = (state ? 1.0:0.5)
    }
    
    
    
    func dismissPopup() {
        self.dismiss(animated: true) {
        }
    }
    
}
