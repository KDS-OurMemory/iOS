//
//  SelectAlramTimeViewController.swift
//  OurMemory
//
//  Created by 이승기 on 2022/02/05.
//

import UIKit

class SelectAlramTimeViewController: BaseViewController {

    @IBOutlet weak var selectedAlarmInfoLbl: UILabel!
    @IBOutlet weak var alarmItemScrollView: BaseScrollView!
    @IBOutlet weak var confirmBtn: UIButton!
    @IBOutlet weak var cancelBtn: UIButton!
    
    var selectAlarmTimeCtl:SelectAlarmContract?
    var selectAlarmBlock:((String) -> Void)?
    var alarmBtnList:[SelectBoxButton] = []
    
    override func getDataContract() -> DataContract? {
        return self.selectAlarmTimeCtl
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.setBackgroundDimColor()
    }
    
    override func prepareViewWithData(data: Any?) {
        if self.getDataContract() == nil {
            selectAlarmTimeCtl = CtlMaker().createDataControllerWithContract(contract: .eContractSelectAlramTime, view: self, data: data) as? SelectAlarmContract
            if let ctl = self.getDataContract() as? SelectAlarmContract {
                cancelBtn.addAction { p1 in
                    ctl.actionCancelBtn(sender: p1 as! UIButton)
                }
                
                confirmBtn.addAction { p1 in
                    ctl.actionConfirmBtn(sender: p1 as! UIButton)
                }
            }
        }
    }
    
    func setSelectAlarmBlock(block:(@escaping (String) -> Void)) {
        selectAlarmBlock = block
    }

}

extension SelectAlramTimeViewController: SelectAlarmView {
    
    func updateAlarmList(alarmList:[String]) {
        for alarm in alarmList {
            let selectBoxBtn:SelectBoxButton = SelectBoxButton()
            selectBoxBtn.setTitleColor(.black, for: .normal)
            selectBoxBtn.setTitle(alarm, for: .normal)
            alarmItemScrollView.addVerScrollSubView(subView: selectBoxBtn, viewSize: selectBoxBtn.frame.size, verPadding: 25)
            alarmBtnList.append(selectBoxBtn)
            selectBoxBtn.addAction { p1 in
                if let ctl = self.selectAlarmTimeCtl {
                    ctl.selectAlarmIdx(idx: self.alarmBtnList.firstIndex(of: selectBoxBtn)!)
                }
            }
        }
    }
    
    func updateSelectedAlarmTitle(title:String) {
        selectedAlarmInfoLbl.text = title + "알람이 도착합니다."
    }
    
    func applySelectedAlarms(alarms:String) {
        if let block = selectAlarmBlock {
            block(alarms)
        }
    }
    
    func enableSelectedAlarmIndex(idx:Int) {
        alarmBtnList[idx].isSelected = true
    }
    
    func disableSelectedAlarmIndex(idx:Int) {
        alarmBtnList[idx].isSelected = false
    }
    
    func dismissPopup() {
        self.dismiss(animated: true) {
            
        }
    }
    
}
