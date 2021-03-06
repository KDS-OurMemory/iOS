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
    var date = Date();
    let cal = Calendar.current;
    var components:DateComponents!
    var monthDateCal:[calCellData] = []

    override init() {
        super.init()
        self.components = self.cal.dateComponents([.year,.month,.day], from: self.date)
        self.setMonthofCal()
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
    
    var startOfDay:Date {
        return Calendar.current.startOfDay(for: self.date)
    }
    
    var startOfMonth: Date {
        
        let calendar = Calendar(identifier: .gregorian)
        let components = calendar.dateComponents([.year, .month], from:  self.date)
        
        return  calendar.date(from: components)!
    }
    
    var endOfDay: Date {
        var components = DateComponents()
        components.day = 1
        components.second = -1
        return Calendar.current.date(byAdding: components, to: self.startOfDay)!
    }
    
    var endOfMonth: Date {
        var components = DateComponents()
        components.month = 1
        components.second = -1
        return Calendar(identifier: .gregorian).date(byAdding: components, to: self.startOfMonth)!
    }
    
    var prevLastDayOfMonth: Date {
        let calendar = Calendar(identifier: .gregorian)
        var components = calendar.dateComponents([.year, .month, .day], from: self.date)
        components.day = 0
        return calendar.date(from: components)!
    }
    
    var nextFirstDayOfMonth: Date {
        let calendar = Calendar(identifier: .gregorian)
        var components = calendar.dateComponents([.year, .month, .day], from: self.date)
        components.month = components.month! + 1
        components.day = 1
        return calendar.date(from: components)!
    }
    
    func isMonday() -> Bool {
        let calendar = Calendar(identifier: .gregorian)
        let components = calendar.dateComponents([.weekday], from:  self.date)
        return components.weekday == 2
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

    func setMonth(month:Int) {
        self.components.setValue(month, for: .month)
        if let date = self.cal.date(from: self.components) {
            self.date = date
            self.setMonthofCal()
        }
    }
    
    func setDay(day:Int) {
        self.components.setValue(day, for: .day)
        if let date = self.cal.date(from: self.components) {
            self.date = date
        }
    }
 
    func getDayofDate(date:Date) -> Int {
        return cal.dateComponents([.day], from: date).day!
    }
    
    func getWeekDayofDate(date:Date) -> Int {
        return cal.dateComponents([.weekday], from: date).weekday!
    }
    
    func getWeekCntofMonth() -> Int {
         var calendar = Calendar(identifier: .gregorian)
         calendar.firstWeekday = 1
         let weekRange = calendar.range(of: .weekOfMonth,
                                        in: .month,
                                        for: self.date)
         return weekRange!.count
    }
    
    func getCalendarDate() -> [calCellData] {
        return self.monthDateCal
    }
    
    func getCalendarDateCnt() -> Int {
        return self.monthDateCal.count
    }
    
    func setMonthofCal() {
        self.monthDateCal.removeAll()
        let prevWeekday = self.getWeekDayofDate(date: self.prevLastDayOfMonth)
        if prevWeekday < 7
        {
            for weekDay in 1...prevWeekday {
                let day = self.getDayofDate(date: self.prevLastDayOfMonth) - (prevWeekday - weekDay)
                let data = calCellData(num: "\(day)", state: dateState.prev, weekDay: WEEKDAYS(rawValue: Int8(weekDay))!, weekPoint: self.monthDateCal.count/7)
                self.monthDateCal.append(data);
            }
        }
        
        var currentWeekDay = self.getWeekDayofDate(date: self.startOfMonth)
        for day in self.getDayofDate(date: self.startOfMonth)...self.getDayofDate(date: self.endOfMonth) {
            let data = calCellData(num: "\(day)", state: dateState.current, weekDay: WEEKDAYS(rawValue: Int8(currentWeekDay))!, weekPoint: self.monthDateCal.count/7)
            if currentWeekDay == 7 {
                currentWeekDay = 1
            }else {
                currentWeekDay += 1
            }
            self.monthDateCal.append(data)
        }
        
        if self.getWeekDayofDate(date: self.nextFirstDayOfMonth) > 1 {
            var day = 1
            for weekDay in self.getWeekDayofDate(date: self.nextFirstDayOfMonth)...7
            {
                let data = calCellData(num: "\(day)", state: dateState.next, weekDay: WEEKDAYS(rawValue: Int8(weekDay))!, weekPoint: self.monthDateCal.count/7)
                day += 1
                self.monthDateCal.append(data)
            }
        }
    }
    
    
}

protocol roomDetailCalCell {
    func setDate(date:calCellData)
    func changeStateCell(data:calCellData,state:ROOMDETAILSCROLLPOINT)
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
            view.setUpDefine()
            view.setUpLayout()
            
        }
        
    }
    
    func configure(cell:roomDetailCalCell,date:calCellData) {
        cell.setDate(date: date)
    }
    
    func changeState(cell:roomDetailCalCell,data:calCellData,state:ROOMDETAILSCROLLPOINT){
        cell.changeStateCell(data: data, state: state)
    }
    
    func getYear() -> Int? {
        return self.roomDetailModel.getYear()
    }
    
    func getMonth() -> Int? {
        return self.roomDetailModel.getMonth()
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
   
    func getWeekCntofMonth() -> Int {
        return self.roomDetailModel.getWeekCntofMonth()
    }
}

enum ROOMDETAILSCROLLPOINT {
    case TOPMIDTOP
    case TOPMIDBOT
    case MID
    case BOTMIDTOP
    case BOTMIDBOT
    case OUTSCREEN
    case UNKWNON
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
    
    @IBOutlet var moveCal: UICollectionView!
    @IBOutlet var moveCalHeightConstraints: NSLayoutConstraint!
    
    @IBOutlet var upandDownView: UIView!
    @IBOutlet weak var weekDaysStackView: UIStackView!
    
    var screenWidth:CGFloat!
    var screenHeight:CGFloat!
    
    var contentScreenHeight:CGFloat!
    var contentsViewCenterY:CGFloat!
    
    var contentsviewTop:CGFloat!
    var movecalOriginSize:CGFloat!
    
    let roomDetailCtlMaker:RoomDetailCtlMaker = RoomDetailCtlMaker()
    var roomDetailCtl:RoomDetailCtl?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        roomDetailCtlMaker.configure(roomDetailView: self)
        
        roomDetailCtl?.onViewDidLoad()
        let nib = UINib(nibName: "RoomDetailCalCollectionViewCell", bundle: nil)
    
        self.moveCal.register(nib, forCellWithReuseIdentifier: "RoomDetailCalCollectionViewCell")
        
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        coordinator.animate { _ in
            self.moveCal.collectionViewLayout.invalidateLayout()
        }
    }
    
    func setUpDefine() {
        screenWidth = self.view.frame.size.width
        screenHeight = self.view.frame.size.height
        
        contentScreenHeight = self.screenHeight-self.topViewHeightConstraints.constant - self.weekDaysStackView.frame.size.height-50
        contentsViewCenterY = self.contentScreenHeight*0.5
        contentsviewTop = self.weekDaysStackView.frame.origin.y
    }
    
    func setUpLayout() {
        
        let calGesture = UIPanGestureRecognizer(target: self, action: #selector(self.wasCalDragged(gestureRecognizer:)))
        self.moveCal.addGestureRecognizer(calGesture)
        self.moveCal.delegate = self
        self.moveCal.dataSource = self
        
        self.movecalOriginSize = self.contentsViewCenterY - self.contentsviewTop
        self.moveCalHeightConstraints.constant = self.movecalOriginSize
        calGesture.delegate = self
        
        let viewGesture = UIPanGestureRecognizer(target: self, action: #selector(self.wasViewDragged(gestureRecognizer:)))
        upandDownView.addGestureRecognizer(viewGesture)
        upandDownView.isUserInteractionEnabled = true
        viewGesture.delegate = self
    }

    // MARK: ViewContract
    
    func updateYearAndMonth(year:Int ,month: Int) {
        self.detePickerBtn.setTitle("\(year).\(month)", for: UIControl.State.normal)
    }
    
}

extension RoomDetailViewController:UIGestureRecognizerDelegate {
    
    @objc func wasCalDragged(gestureRecognizer: UIPanGestureRecognizer) {
        let translation = gestureRecognizer.translation(in: self.view)
        if gestureRecognizer.state == UIGestureRecognizer.State.began || gestureRecognizer.state == UIGestureRecognizer.State.changed {
            if(gestureRecognizer.view!.center.y <= self.contentsViewCenterY) || (gestureRecognizer.view!.center.y >= self.contentsviewTop ) {
                
                if self.upandDownView.frame.origin.y > self.contentsViewCenterY
                {
                    self.moveCalHeightConstraints.constant = self.moveCalHeightConstraints.constant + translation.y
                }
                if self.upandDownView.frame.origin.y <= self.screenHeight
                {
                    self.upandDownView.frame.origin.y = self.upandDownView.frame.origin.y - translation.y
                }
                if self.moveCalHeightConstraints.constant > self.contentScreenHeight {
                    self.moveCalHeightConstraints.constant = self.contentScreenHeight
                }
                
                self.moveCal.reloadData()
                self.moveCal.collectionViewLayout.invalidateLayout()
    
            }
            else {
                gestureRecognizer.view!.frame.origin.y = self.contentsviewTop
            }

            gestureRecognizer.setTranslation(CGPoint(x:0,y:0), in: self.view)
        }else if gestureRecognizer.state == UIGestureRecognizer.State.ended {
            if (self.contentsViewCenterY..<self.contentsViewCenterY*1.5).contains(self.upandDownView.frame.origin.y)  {
                UIView.animate(withDuration: 0.5) {
                    self.moveCalHeightConstraints.constant = self.movecalOriginSize
                    self.upandDownView.frame.origin.y = self.contentsViewCenterY
                } completion: { _ in
                    self.moveCal.reloadData()
                    self.moveCal.collectionViewLayout.invalidateLayout()
                }

            }
            else {
                UIView.animate(withDuration: 0.5) {
                    self.moveCalHeightConstraints.constant = self.contentScreenHeight
                    self.upandDownView.frame.origin.y = self.screenHeight
                }
            }
        }
    }
    
    @objc func wasViewDragged(gestureRecognizer: UIPanGestureRecognizer) {
        let translation = gestureRecognizer.translation(in: self.view)
           print(translation.y)
        
//        print(gestureRecognizer.view?.frame.origin.y)
        if gestureRecognizer.state == UIGestureRecognizer.State.began || gestureRecognizer.state == UIGestureRecognizer.State.changed {
            if(gestureRecognizer.view!.center.y > self.contentsViewCenterY) {
                gestureRecognizer.view!.center = CGPoint(x: gestureRecognizer.view!.center.x, y: gestureRecognizer.view!.center.y+translation.y)
                if (gestureRecognizer.view?.frame.origin.y)! > self.contentsViewCenterY
                {
                    self.moveCalHeightConstraints.constant = self.moveCalHeightConstraints.constant + translation.y
                    UIView.animate(withDuration: 0.2) {
                        self.moveCal.reloadData()
                        self.moveCal.collectionViewLayout.invalidateLayout()
                    }
                    
                }
            }
            else {
                gestureRecognizer.view!.center = CGPoint(x:gestureRecognizer.view!.center.x, y:self.contentsViewCenterY+1)
               }

            gestureRecognizer.setTranslation(CGPoint(x:0,y:0), in: self.view)
        }else if gestureRecognizer.state == UIGestureRecognizer.State.ended {
            if (self.contentsviewTop..<self.contentsViewCenterY/1.5).contains(gestureRecognizer.view!.frame.origin.y) {
                UIView.animate(withDuration: 0.5) {
                    gestureRecognizer.view?.frame.origin.y = self.contentsviewTop
                }
            }else if (self.contentsViewCenterY/1.5..<self.contentsViewCenterY).contains((gestureRecognizer.view?.frame.origin.y)!)  {
                UIView.animate(withDuration: 0.5) {
                    gestureRecognizer.view?.frame.origin.y = self.contentsViewCenterY
                    self.moveCalHeightConstraints.constant = (gestureRecognizer.view?.frame.origin.y)! - self.contentsviewTop
                    UIView.animate(withDuration: 0.5) {
                        self.moveCal.reloadData()
                        self.moveCal.collectionViewLayout.invalidateLayout()
                    }
                }
            }else if (self.contentsViewCenterY..<self.contentsViewCenterY*1.5).contains((gestureRecognizer.view?.frame.origin.y)!)  {
                UIView.animate(withDuration: 0.5) {
                    self.moveCalHeightConstraints.constant = self.movecalOriginSize
                    gestureRecognizer.view?.frame.origin.y = self.contentsViewCenterY
                } completion: { _ in
                    UIView.animate(withDuration: 0.5) {
                        self.moveCal.reloadData()
                        self.moveCal.collectionViewLayout.invalidateLayout()
                    }
                }

            }
            else {
                UIView.animate(withDuration: 0.5) {
                    gestureRecognizer.view?.frame.origin.y = self.screenHeight
                    self.moveCalHeightConstraints.constant = (gestureRecognizer.view?.frame.origin.y)! - self.contentsviewTop
                    UIView.animate(withDuration: 0.5) {
                        self.moveCal.reloadData()
                        self.moveCal.collectionViewLayout.invalidateLayout()
                    }
                }
            }
        }
        
    }
    
    func checkScrollPoint(ypoint:CGFloat) -> ROOMDETAILSCROLLPOINT {

        if (ypoint == self.contentsViewCenterY)
        {
            return ROOMDETAILSCROLLPOINT.MID
        }
        if (self.contentsviewTop..<self.contentsViewCenterY/1.5).contains(ypoint) {
            return ROOMDETAILSCROLLPOINT.TOPMIDTOP
        }else if (self.contentsViewCenterY/1.5..<self.contentsViewCenterY).contains(ypoint) {
            return ROOMDETAILSCROLLPOINT.TOPMIDBOT
        }else if (self.contentsViewCenterY..<self.contentsViewCenterY*1.5).contains(ypoint) {
            return ROOMDETAILSCROLLPOINT.BOTMIDTOP
        }else if (self.contentsViewCenterY*1.5..<self.screenHeight).contains(ypoint) {
            return ROOMDETAILSCROLLPOINT.BOTMIDBOT
        }else{
            return ROOMDETAILSCROLLPOINT.OUTSCREEN
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
            self.roomDetailCtl?.changeState(cell: cell, data: data[indexPath.row], state: self.checkScrollPoint(ypoint: self.upandDownView.frame.origin.y))
        }
        
        return cell
    }


}

extension RoomDetailViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let weekcnt = CGFloat((self.roomDetailCtl?.getWeekCntofMonth())!)
        let height = collectionView.frame.size.height / weekcnt
        return CGSize(width: self.screenWidth/7, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    
    
    
}
