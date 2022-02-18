//
//  AddSchduleViewController.swift
//  OurMemory
//
//  Created by 이승기 on 2022/02/05.
//

import UIKit
import OurMemoryTask

class AddSchduleViewController: BaseViewController {

    @IBOutlet weak var scheduleConfrimBtn: UIButton!
    @IBOutlet weak var scheduleCloseBtn: UIButton!
    @IBOutlet weak var scheduleTf: UITextField!
    var addSchduleCtl:AddScheduleContract?
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var scheduleTitleView: UIView!
    @IBOutlet weak var itemScrollView: BaseScrollView!
    
    let itemsHeight = 40
    let dateView:AddScheduleItemView = AddScheduleItemView()
    let contentView:AddScheduleItemView = AddScheduleItemView()
    let locationView:AddScheduleItemView = AddScheduleItemView()
    let alarmView:AddScheduleItemView = AddScheduleItemView()
    let colorView:AddScheduleItemView = AddScheduleItemView()
    let sharedView:AddScheduleItemView = AddScheduleItemView()
    
    override func getDataContract() -> DataContract? {
        return self.addSchduleCtl
    }
    
    override func prepareViewWithData(data: Any?) {
        
        scheduleConfrimBtn.setTitle("", for: .normal)
        scheduleCloseBtn.setTitle("", for: .normal)
        
        scheduleTf.delegate = self
        
        scheduleCloseBtn.addAction { p1 in
            if let ctl = self.getDataContract() as? AddScheduleContract {
                ctl.actionCloseBtn(sender: p1 as! UIButton)
            }
        }
        
        scheduleConfrimBtn.addAction { p1 in
            if let ctl = self.getDataContract() as? AddScheduleContract {
                ctl.actionConfirmBtn(sender: p1 as! UIButton)
            }
        }
        
        dateView.frame = CGRect(x: 0, y: 0, width: Int(mainWidth), height: itemsHeight)
        dateView.setIconWithTitle(iconImg: UIImage(systemName: "pencil")!, title: "날짜", titleColor: .black)
        dateView.setClickBtnBlock {
            if let ctl = self.getDataContract() as? AddScheduleContract {
                ctl.actionDatesView()
            }
        }
        
        contentView.frame = CGRect(x: 0, y: 0, width: Int(mainWidth), height: itemsHeight)
        contentView.setIconWithTitle(iconImg: UIImage(systemName: "pencil")!, title: "내용", titleColor: .black)
        contentView.setClickBtnBlock {
            if let ctl = self.getDataContract() as? AddScheduleContract {
                ctl.actionContentsView()
            }
        }
        
        locationView.frame = CGRect(x: 0, y: 0, width: Int(mainWidth), height: itemsHeight)
        locationView.setIconWithTitle(iconImg: UIImage(systemName: "pencil")!, title: "장소", titleColor: .black)
        locationView.setClickBtnBlock {
            if let ctl = self.getDataContract() as? AddScheduleContract {
                ctl.actionLocationsView()
            }
        }
        
        alarmView.frame = CGRect(x: 0, y: 0, width: Int(mainWidth), height: itemsHeight)
        alarmView.setIconWithTitle(iconImg: UIImage(systemName: "pencil")!, title: "알람", titleColor: .black)
        alarmView.setClickBtnBlock {
            if let ctl = self.getDataContract() as? AddScheduleContract {
                ctl.actionAlarmsView()
            }
        }
        
        colorView.frame = CGRect(x: 0, y: 0, width: Int(mainWidth), height: itemsHeight)
        colorView.setIconWithTitle(iconImg: UIImage(systemName: "pencil")!, title: "색상", titleColor: .black)
        colorView.setClickBtnBlock {
            if let ctl = self.getDataContract() as? AddScheduleContract {
                ctl.actionColorView()
            }
        }
        
        sharedView.frame = CGRect(x: 0, y: 0, width: Int(mainWidth), height: itemsHeight)
        sharedView.setIconWithTitle(iconImg: UIImage(systemName: "pencil")!, title: "공유", titleColor: .black)
        sharedView.setClickBtnBlock {
            if let ctl = self.getDataContract() as? AddScheduleContract {
                ctl.actionSharedView()
            }
        }
        
        if self.getDataContract() == nil {
            addSchduleCtl = CtlMaker().createDataControllerWithContract(contract: .eContractAddSchedule, view: self, data: data) as? AddScheduleContract
        }
        
        
    }
    
    override func showNextVC(vc: NEXTVIEW, data: Any?) {
        switch vc {
        case .NEXTVIEW_SELECTDATE:
            self.navigate(vc,animation: false ,data: data, onInitVc: { vc in
                if let toVc = vc as? SelectDateViewController,let ctl = self.addSchduleCtl {
                    toVc.setSelectedDateBlock { p1 in
                        ctl.addDate(date: p1)
                    }
                }
            })
            break
        case .NEXTVIEW_SELECTCOLOR:
            self.navigate(vc,animation: false ,data: data, onInitVc: { vc in
                if let toVc = vc as? SelectColorViewController,let ctl = self.addSchduleCtl {
                    toVc.setSelectColorBlock { p1 in
                        ctl.setColor(color: p1)
                    }
                }
            })
            break
        case .NEXTVIEW_SELECTSHARED:
            self.navigate(vc,animation: false ,data: data, onInitVc: { vc in
                if let toVc = vc as? SelectSharedViewController,let ctl = self.addSchduleCtl {
                    
                }
            })
            break
        case .NEXTVIEW_SELECTALRAMTIME:
            self.navigate(vc,animation: false ,data: data, onInitVc: { vc in
                if let toVc = vc as? SelectAlramTimeViewController,let ctl = self.addSchduleCtl {
                    toVc.setSelectAlarmBlock { p1 in
                        ctl.setAlarm(alarm: p1)
                    }
                }
            })
            break
        case .NEXTVIEW_POP:
            self.navigate(vc, animation: true, data: nil, onInitVc: nil)
            break
        default:
            break
        }
    }
}

extension AddSchduleViewController:AddScheduleView {
    
    
    func updateScheduleData(dataBinder: ScheduleDataBinder) {
        self.itemScrollView.resetSubViews()
        
        dateView.setItem(item: .itemDate, contents: dataBinder)
        self.itemScrollView.addVerScrollSubView(subView: dateView, viewSize: dateView.frame.size, verPadding: 20)
        contentView.setItem(item: .itemContent, contents: dataBinder)
        self.itemScrollView.addVerScrollSubView(subView: contentView, viewSize: contentView.frame.size, verPadding: 20)
        locationView.setItem(item: .itemLocation, contents: dataBinder)
        self.itemScrollView.addVerScrollSubView(subView: locationView, viewSize: locationView.frame.size, verPadding: 20)
        
        self.itemScrollView.addVerScrollSubView(subView: alarmView, viewSize: alarmView.frame.size, verPadding: 20)
        
        self.itemScrollView.addVerScrollSubView(subView: colorView, viewSize: colorView.frame.size, verPadding: 20)
        
        self.itemScrollView.addVerScrollSubView(subView: sharedView, viewSize: sharedView.frame.size, verPadding: 20)
    }
    
    func updaetConfirmBtnState(state:Bool) {
        scheduleConfrimBtn.isEnabled = state
        scheduleConfrimBtn.alpha = (state ? 1.0:0.3)
    }
    
    func updateAlarm(alarm:String) {
        alarmView.setTitle(title: alarm)
    }
    
    func updateColor(color: UIColor) {
        colorView.setTitleWithColor(title: "색상", titleColor: color)
    }
    
    
}

extension AddSchduleViewController:UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let ctl = self.getDataContract() as? AddScheduleContract, let text = textField.text {
            ctl.setScheduleTitle(title: text)
        }
    }
}
