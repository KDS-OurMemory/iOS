//
//  AddSchduleViewController.swift
//  OurMemory
//
//  Created by 이승기 on 2022/02/05.
//

import UIKit
import OurMemoryTask

class AddSchduleViewController: BaseViewController {

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
        
        if self.getDataContract() == nil {
            addSchduleCtl = CtlMaker().createDataControllerWithContract(contract: .eContractAddSchedule, view: self, data: data) as? AddScheduleContract
        }
        
        dateView.frame = CGRect(x: 0, y: 0, width: Int(mainWidth), height: itemsHeight)
        dateView.setIconWithTitle(iconImg: UIImage(), title: "날짜", titleColor: .black)
        contentView.frame = CGRect(x: 0, y: 0, width: Int(mainWidth), height: itemsHeight)
        contentView.setIconWithTitle(iconImg: UIImage(), title: "내용", titleColor: .black)
        locationView.frame = CGRect(x: 0, y: 0, width: Int(mainWidth), height: itemsHeight)
        locationView.setIconWithTitle(iconImg: UIImage(), title: "장소", titleColor: .black)
        alarmView.frame = CGRect(x: 0, y: 0, width: Int(mainWidth), height: itemsHeight)
        alarmView.setIconWithTitle(iconImg: UIImage(), title: "알람", titleColor: .black)
        colorView.frame = CGRect(x: 0, y: 0, width: Int(mainWidth), height: itemsHeight)
        colorView.setIconWithTitle(iconImg: UIImage(), title: "색상", titleColor: .black)
        sharedView.frame = CGRect(x: 0, y: 0, width: Int(mainWidth), height: itemsHeight)
        sharedView.setIconWithTitle(iconImg: UIImage(), title: "공유", titleColor: .black)
        
    }
    
    override func showNextVC(vc: NEXTVIEW, data: Any?) {
        switch vc {
        case .NEXTVIEW_SELECTDATE:
            if let vc = self.navigate(vc, data: data) as? SelectDateViewController,let ctl = self.addSchduleCtl {
                vc.setSelectedDateBlock { p1 in
                    ctl.addDate(date: p1)
                }
            }
            break
        default:
            break
        }
    }
}

extension AddSchduleViewController:AddScheduleView {
    
    func updateScheduleData(dataBinder: ScheduleDataBinder) {
        self.itemScrollView.resetSubViews()
        
        dateView.setItem(item: .itemDate, contents: dataBinder.getDates())
        self.itemScrollView.addVerScrollSubView(subView: dateView, viewSize: dateView.frame.size, verPadding: 0)
        contentView.setItem(item: .itemContent, contents: dataBinder.getContents())
        self.itemScrollView.addVerScrollSubView(subView: contentView, viewSize: contentView.frame.size, verPadding: 0)
        locationView.setItem(item: .itemLocation, contents: dataBinder.getLocations())
        self.itemScrollView.addVerScrollSubView(subView: locationView, viewSize: locationView.frame.size, verPadding: 0)
        
        self.itemScrollView.addVerScrollSubView(subView: alarmView, viewSize: alarmView.frame.size, verPadding: 0)
        
        self.itemScrollView.addVerScrollSubView(subView: colorView, viewSize: colorView.frame.size, verPadding: 0)
        
        self.itemScrollView.addVerScrollSubView(subView: sharedView, viewSize: sharedView.frame.size, verPadding: 0)
    }
    
    
}
