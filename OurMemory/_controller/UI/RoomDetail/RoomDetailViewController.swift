//
//  RoomDetailViewController.swift
//  OurMemory
//
//  Created by 이승기 on 2021/03/22.
//

import UIKit

enum WEEKDAYS:Int8 {
    case MONDAY = 0
    case TUESDAY
    case WEDNESDAY
    case THURSDAY
    case FRIDAY
    case SATURDAY
    case SUNDAY
}

class RoomDetailDateComponentsModel: NSObject {
    let date = Date();
    let cal = Calendar.current;
    var components:DateComponents!

    override init() {
        self.components = self.cal.dateComponents([.year,.month,.day], from: self.date)
    }
    
    func getComponentsDate() -> Date {
        if let date = self.components.date
        {
            return date
        }
        return Date()
    }
    
    func getCurrentDate() -> DateComponents {
         return self.cal.dateComponents([.year,.month,.day], from: self.date)
    }
    
    func getDayCntOfMonth() -> Int? {
        if let dayCnt = self.cal.ordinality(of: .day, in: .month, for: self.getComponentsDate()) {
            return dayCnt
        }
        return nil
    }
    
    func getFirstDate() -> Date? {
        if let date = self.cal.dateComponents([.year,.month], from: self.getComponentsDate()).date
        {
            return date
        }
        return nil
    }
    
    func getFirstWeekDay() -> Int? {
        if let firstWeekDay = self.cal.dateComponents([.year,.month], from: self.getComponentsDate()).weekday {
            return firstWeekDay
        }
        return nil
    }
    
    func prevMonthDate() -> Date {
        return self.cal.date(byAdding: .day, value: -1, to: self.getFirstDate()!)!
    }

    func prevMonthLastDay() -> Int? {
        if let lastDay = self.cal.dateComponents([.day], from: self.prevMonthDate()).day {
            return lastDay
        }
        return nil
    }

    func prevMonthLastWeekDay() -> Int? {
        if let lastWeekDay = self.cal.dateComponents([.day], from: self.prevMonthDate()).weekday {
            return lastWeekDay
        }
        return nil
    }
    
    func getMonth() -> Int? {
        if let month = self.components.month
        {
            return month
        }
        return nil
    }
    
    func getYear() -> Int? {
        if let year = self.components.year
        {
            return year
        }
        return nil
    }
    
    func getToday() -> Int? {
        if let day = self.getCurrentDate().day {
            return day
        }
        return nil
    }
    
    func getWeekToDay() -> Int? {
        if let weekDay = self.getCurrentDate().weekday
        {
            return weekDay
        }
        return nil
    }
    
    func getCurrentMonthCnt() -> Int {
        return 0
    }
    
    func setMonth(month:Int) {
        self.components.setValue(month, for: .month)
    }
    
    func setDay(day:Int) {
        self.components.setValue(day, for: .day)
    }
}

class RoomDetailCtl
{
    let roomDetailModel:RoomDetailDateComponentsModel = RoomDetailDateComponentsModel()
    var view:RoomDetailViewContract?
    
    init(view:RoomDetailViewContract) {
        self.view = view
    }
    
    func onViewDidLoad() {
        if let view = self.view
        {
            if let year = self.getYear(), let month = self.getMonth()
            {
                view.updateYearAndMonth(year: year, month: month)
            }
            view.setUpLayout()
            view.setUpDefine()
        }
        
    }
    
    func getYear() -> Int? {
        return self.roomDetailModel.getYear()
    }
    
    func getMonth() -> Int? {
        return self.roomDetailModel.getMonth()
    }
    
    func getDayCntOfMonth() -> Int? {
        return self.roomDetailModel.getDayCntOfMonth()
    }
    
    func getToday() -> Int? {
        return self.roomDetailModel.getToday()
    }
    
    func getWeekToDay() -> Int? {
        return self.roomDetailModel.getWeekToDay()
    }
    
    func setMonth(month:Int) {
        self.roomDetailModel.setMonth(month: month)
    }
    
    func setDay(day:Int) {
        self.roomDetailModel.setDay(day: day)
    }
}

protocol RoomDetailViewContract {
    func updateYearAndMonth(year:Int ,month: Int)
    func setUpLayout()
    func setUpDefine()
}

class RoomDetailCtlMaker {
    func configure(roomDetailView:RoomDetailViewController) {
        let ctl = RoomDetailCtl.init(view: roomDetailView)
        roomDetailView.roomDetailCtl = ctl
    }
}

class RoomDetailViewController: BaseViewController, RoomDetailViewContract {

    @IBOutlet weak var sideMenuBtn: UIButton!
    @IBOutlet var topViewHeightConstraints: NSLayoutConstraint!
    
    @IBOutlet weak var detePickerBtn: UIButton!
    
    @IBOutlet weak var showCalList: UIButton!
    
    @IBOutlet var originalCal: UICollectionView!
    
    @IBOutlet var moveCal: UICollectionView!
    @IBOutlet var moveCalHeightConstraints: NSLayoutConstraint!
    
    @IBOutlet var upandDownView: UIView!
    
    var screenWidth:CGFloat!
    var screenHeight:CGFloat!
    
    var contentsViewCenterY:CGFloat!
    
    let roomDetailCtlMaker:RoomDetailCtlMaker = RoomDetailCtlMaker()
    var roomDetailCtl:RoomDetailCtl?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        roomDetailCtlMaker.configure(roomDetailView: self)
        
        roomDetailCtl?.onViewDidLoad()
        
        
    }
    
    func setUpDefine() {
        screenWidth = self.view.frame.size.width
        screenHeight = self.view.frame.size.height
        
        contentsViewCenterY = (self.screenHeight-self.topViewHeightConstraints.constant)*0.7
    }
    
    func setUpLayout() {
        let gesture = UIPanGestureRecognizer(target: self, action: #selector(self.wasDragged(gestureRecognizer:)))
        upandDownView.addGestureRecognizer(gesture)
        upandDownView.isUserInteractionEnabled = true
        gesture.delegate = self
        
        self.originalCal.delegate = self
//        self.originalCal.dataSource = self
        
        self.moveCal.delegate = self
//        self.moveCal.dataSource = self
        
    }

    // MARK: ViewContract
    
    func updateYearAndMonth(year:Int ,month: Int) {
        self.detePickerBtn.setTitle("\(year).\(month)", for: UIControl.State.normal)
    }
    
}

extension RoomDetailViewController:UIGestureRecognizerDelegate {
    
    @objc func wasDragged(gestureRecognizer: UIPanGestureRecognizer) {
        if gestureRecognizer.state == UIGestureRecognizer.State.began || gestureRecognizer.state == UIGestureRecognizer.State.changed {
            let translation = gestureRecognizer.translation(in: self.view)
               print(translation.y)
            if(gestureRecognizer.view!.center.y > self.contentsViewCenterY) {
                gestureRecognizer.view!.center = CGPoint(x: gestureRecognizer.view!.center.x, y: gestureRecognizer.view!.center.y+translation.y)
                self.moveCalHeightConstraints.constant = self.moveCalHeightConstraints.constant + translation.y
            }
            else {
                gestureRecognizer.view!.center = CGPoint(x:gestureRecognizer.view!.center.x, y:self.contentsViewCenterY+1)
               }

            gestureRecognizer.setTranslation(CGPoint(x:0,y:0), in: self.view)
        }else if gestureRecognizer.state == UIGestureRecognizer.State.ended {
            if (self.contentsViewCenterY...self.contentsViewCenterY*1.5).contains(gestureRecognizer.view!.center.y) {
                gestureRecognizer.view!.center = CGPoint(x: gestureRecognizer.view!.center.x, y: self.contentsViewCenterY)
            }else if (self.contentsViewCenterY*1.5...self.contentsViewCenterY*3).contains(gestureRecognizer.view!.center.y) {
                gestureRecognizer.view!.center = CGPoint(x: gestureRecognizer.view!.center.x, y: self.contentsViewCenterY*2)
            }else {
                gestureRecognizer.view!.center = CGPoint(x: gestureRecognizer.view!.center.x, y: self.contentsViewCenterY*3)
            }
        }
    }

}

extension RoomDetailViewController: UICollectionViewDelegate {
    
}

//extension RoomDetailViewController: UICollectionViewDataSource {
//
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        <#code#>
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        <#code#>
//    }
//
//
//}
