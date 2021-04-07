//
//  RoomDetailViewController.swift
//  OurMemory
//
//  Created by 이승기 on 2021/03/22.
//

import UIKit

enum WEEKDAYS:Int8 {
    case SUNDAY = 1
    case MONDAY
    case TUESDAY
    case WEDNESDAY
    case THURSDAY
    case FRIDAY
    case SATURDAY
}

class RoomDetailDateComponentsModel: NSObject {
    let date = Date();
    let cal = Calendar.current;
    var components:DateComponents!
    var monthDateCal:[calCellData] = []

    override init() {
        super.init()
        self.components = self.cal.dateComponents([.year,.month,.day], from: self.date)
        self.setCalendarDate()
    }
    
    func getComponentsDate() -> Date {
        if let date = self.cal.date(from: self.components)
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
    
//    func getFirstDate() -> Date? {
//        if let date = self.cal.dateComponents([.year,.month], from: self.getComponentsDate()).date
//        {
//            return date
//        }
//        return nil
//    }
    
    func getFirstWeekDay() -> Int? {
        if let firstWeekDay = self.cal.dateComponents([.year,.month], from: self.getComponentsDate()).weekday {
            return firstWeekDay
        }
        return nil
    }
    
    func prevMonthDate() -> Date {
        return self.cal.date(byAdding: .day, value: -1, to: self.getComponentsDate())!
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
    
    func nextMonthDate() -> Date {
        return self.cal.date(byAdding: DateComponents(month:+1,day: 1), to: self.getComponentsDate())!
    }
    
    func nextMonthFirstWeekDay() -> Int? {
        if let weekDay = self.cal.dateComponents([.day], from: self.nextMonthDate()).weekday {
            return weekDay
        }
        return 0
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
//
//    func getCurrentMonthCnt() -> Int {
//        if let weekDay = self.getWeekToDay(), let daycntofmonth = self.getDayCntOfMonth(), let monthlastWeekDay = self.prevMonthLastWeekDay() {
//           return 7 - weekDay + daycntofmonth + 7 - monthlastWeekDay
//        }
//        return 0
//    }
    
    func setCalendarDate() {
        self.monthDateCal.removeAll()
        if let prevLastWeekday = self.prevMonthLastWeekDay() {
            if prevLastWeekday < 7 {
                if let prevLastDay = self.prevMonthLastDay() {
                    var temparr:[calCellData] = []
                    for prevDay in 0..<prevLastWeekday
                    {
                        let num:String = "\(prevLastDay - prevDay)"
                        let data = calCellData(num: num, state: dateState.prev)
                        temparr.append(data)
                    }
                    self.monthDateCal = temparr.reversed()
                }
            }
        }
        
        if let monthCnt = self.getDayCntOfMonth() {
            for day in 1...monthCnt {
                let data = calCellData(num: "\(day)", state: dateState.current)
                self.monthDateCal.append(data)
            }
        }
        
        if let nextFirstWeekday = self.nextMonthFirstWeekDay() {
            if nextFirstWeekday > 1 {
                for day in nextFirstWeekday...7 {
                    let data = calCellData(num: "\(day)", state: dateState.next)
                    self.monthDateCal.append(data)
                }
            }
        }
        
    }
    
    func getCalendarDate() -> [calCellData] {
        return self.monthDateCal
    }
    
    func getCalendarDateCnt() -> Int {
        return self.monthDateCal.count
    }
    
    func setMonth(month:Int) {
        self.components.setValue(month, for: .month)
        self.setCalendarDate()
    }
    
    func setDay(day:Int) {
        self.components.setValue(day, for: .day)
    }
}

protocol roomDetailCalCell {
    func setDate(date:calCellData)
    func setViewLine(flag:Bool)
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
    
    func configure(cell:roomDetailCalCell,date:calCellData) {
        cell.setDate(date: date)
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
    
    func getCalendarDate() -> [calCellData] {
        return self.roomDetailModel.getCalendarDate()
    }
    
    func getCalendarCnt() -> Int {
        return self.roomDetailModel.getCalendarDateCnt()
    }
   
}

protocol RoomDetailViewContract {
    func updateYearAndMonth(year:Int ,month: Int)
    func setUpLayout()
    func setUpDefine()
}
// MARK: CtlConfigure
class RoomDetailCtlMaker {
    func configure(roomDetailView:RoomDetailViewController) {
        let ctl = RoomDetailCtl.init(view: roomDetailView)
        roomDetailView.roomDetailCtl = ctl
    }
}
// MARK: View
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
        self.originalCal.dataSource = self
        
        self.moveCal.delegate = self
        self.moveCal.dataSource = self
        
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

extension RoomDetailViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let dayCnt = self.roomDetailCtl?.getCalendarCnt() {
            return dayCnt
        }
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RoomDetailCalCollectionViewCell", for: indexPath) as! RoomDetailCalCollectionViewCell
        if let data = self.roomDetailCtl?.getCalendarDate(){
            self.roomDetailCtl?.configure(cell: cell, date: data[indexPath.row])
        }
        
        return cell
    }


}
