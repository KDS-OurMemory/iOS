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

protocol roomDetailCalCell {
    func setDate(date:calCellData)
    func changeStateCell(data:calCellData,state:ROOMDETAILSCROLLPOINT)
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

class RoomDetailViewController: BaseViewController {

    @IBOutlet var topViewHeightConstraints: NSLayoutConstraint!

    @IBOutlet var moveCal: UICollectionView!
    @IBOutlet var moveCalHeightConstraints: NSLayoutConstraint!

    @IBOutlet var upandDownView: UIView!
    @IBOutlet weak var weekDaysStackView: UIStackView!


    @IBOutlet weak var scheduleSv: BaseScrollView!
    @IBOutlet weak var calPickerBtn: UIButton!
    @IBOutlet weak var topViewContainer: UIView!
    @IBOutlet weak var calLeftBtn: UIButton!
    @IBOutlet weak var calRightBtn: UIButton!
    @IBOutlet weak var selectDayLbl: UILabel!
    @IBOutlet weak var selectDayLunarLbl: UILabel!
    let topView:TopView = TopView()
    @IBOutlet weak var sideMenuUserSv: BaseScrollView!
    @IBOutlet weak var sideMenuLeftBtn: UIButton!
    @IBOutlet weak var sideMenuSettingBtn: UIButton!
    @IBOutlet weak var sideMenuWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var sideMenuLeadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var sideMenuView: UIView!
    
    var screenWidth:CGFloat!
    var screenHeight:CGFloat!

    var contentScreenHeight:CGFloat!
    var contentsViewCenterY:CGFloat!

    var contentsviewTop:CGFloat!
    var movecalOriginSize:CGFloat!

    var roomDetailCtl:RoomDetailContract?
    let roomDetailCollectionAdapter:RoomDetailCollectionAdapter = RoomDetailCollectionAdapter()
    
    override func prepareViewWithData(data: Any?) {
        
        self.moveCal.registCell(cellIdentifier: RoomDetailCalCollectionViewCell.className())
        
        topView.frame = CGRect(x: 0, y: 0, width: self.topViewContainer.frame.width, height: self.topViewContainer.frame.height)
        self.topViewContainer.addSubview(topView)
        
        topView.setLeftBtn(btnTitle: nil, btnImage: UIImage(systemName:"chevron.backward")) {
            self.showNextVC(vc: .NEXTVIEW_POP, data: nil)
        }
        topView.setRightBtn(btnTitle: nil, btnImage: UIImage(systemName: "line.3.horizontal")) {
            self.updateSideMenuState(state: true)
        }
        
        roomDetailCtl = CtlMaker().createDataControllerWithContract(contract: .eContractRoomDetail, view: self, data: data) as? RoomDetailContract
        roomDetailCollectionAdapter.setCollection(collectionView: moveCal)
        roomDetailCtl?.setCollectionWithAdpater(adapter: roomDetailCollectionAdapter)
        moveCal.registCell(cellIdentifier: MyMemoryCollectionViewCell.className())
        
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.updateSideMenuState(state: false)
        super.touchesBegan(touches, with: event)
    }
    
    override func getDataContract() -> DataContract? {
        return self.roomDetailCtl
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        coordinator.animate { _ in
            self.moveCal.collectionViewLayout.invalidateLayout()
        }
    }
    
    override func showNextVC(vc: NEXTVIEW, data: Any?) {
        switch vc {
        case .NEXTVIEW_POP:
            self.navigate(vc, animation: true, data: data, onInitVc: nil)
            break
        default:
            break
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

        self.movecalOriginSize = self.contentsViewCenterY - self.contentsviewTop
        self.moveCalHeightConstraints.constant = self.movecalOriginSize
  
    }


}

extension RoomDetailViewController:RoomDetailView {
    func updateYearMonth(yearMonth: (String, String)) {
        self.calPickerBtn.setTitle("\(yearMonth.0).\(yearMonth.1)", for: .normal)
    }
    
    func updateScheduleDatas(datas: [ScheduleDateDataBinder]?) {
        self.scheduleSv.resetSubViews()
        if (datas == nil || datas?.count == 0) {
            let noitemLbl = UILabel(frame: CGRect(x: 0, y: 0, width: mainWidth, height: 30))
            noitemLbl.textColor = .black
            noitemLbl.text = "일정이 존재하지 않습니다."
            self.scheduleSv.addVerScrollSubView(subView: noitemLbl, viewSize: noitemLbl.frame.size, verPadding: 10)
        }else {
            for data in datas! {
                let scheduleView = MyMemoryScheduleView()
                scheduleView.setData(data: data)
                self.scheduleSv.addVerScrollSubView(subView: scheduleView, viewSize: scheduleView.frame.size, verPadding: 50)
                scheduleView.setClickBLock { p1 in
                    if let ctl = self.getDataContract() as? RoomDetailContract {
                        let index = self.scheduleSv.subviews.firstIndex(of: p1)!
                        ctl.selectScheduleIndex(index: index)
                    }
                }
            }
        }
    }
    
    func updateSelectDay(day: String) {
        self.selectDayLbl.text = day
    }
    
    func updateSelectDayLunar(lunar: String) {
        self.selectDayLunarLbl.text = lunar
    }
    
    func updateRoomData(data:RoomDataBinder) {
        topView.setTitle(title: data.getName())
        self.updateRoomMembers(members: data.getMembers())
    }
    
    func updateSideMenuState(state:Bool) {
        UIView.animate(withDuration: 1) {
//            self.sideMenuLeadingConstraint.constant =
            self.sideMenuView.frame = CGRect(x: (state ? mainWidth-self.sideMenuView.frame.width:mainWidth+self.sideMenuView.frame.width), y: 0, width: self.sideMenuView.frame.width, height: self.sideMenuView.frame.height)
        } completion: { _ in
            self.sideMenuView.layoutIfNeeded()
        }
    }
    
    func updateRoomMembers(members:[FriendsDataBinder]) {
        self.sideMenuUserSv.resetSubViews()
        for member in members {
            let userView:RoomUserView = RoomUserView()
            userView.setId(id: member.getName())
            member.getProfileImage { p1 in
                userView.setProfileImg(img: p1 ?? UIImage.init(systemName: "person.circle")!)
            }
            
            self.sideMenuUserSv.addVerScrollSubView(subView: userView, viewSize: userView.frame.size, verPadding: 10)
            userView.clickProfileBlock { p1 in
                self.sideMenuUserSv.subviews.firstIndex(of: p1)
            }
            userView.clickUserBlock { p1 in
                self.sideMenuUserSv.subviews.firstIndex(of: p1)
            }
        }
    }
}

//extension RoomDetailViewController: UICollectionViewDelegate {
//
//}
//
//extension RoomDetailViewController: UICollectionViewDataSource {
//
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        if let dayCnt = self.roomDetailCtl?.getCalendarCnt() {
//            return dayCnt
//        }
//        return 0
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RoomDetailCalCollectionViewCell", for: indexPath) as! RoomDetailCalCollectionViewCell
//        if let data = self.roomDetailCtl?.getCalendarDate(){
//            self.roomDetailCtl?.configure(cell: cell, date: data[indexPath.row])
//            self.roomDetailCtl?.changeState(cell: cell, data: data[indexPath.row], state: self.checkScrollPoint(ypoint: self.upandDownView.frame.origin.y))
//        }
//
//        return cell
//    }
//
//
//}
//
//extension RoomDetailViewController: UICollectionViewDelegateFlowLayout {
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//
//        let weekcnt = CGFloat((self.roomDetailCtl?.getWeekCntofMonth())!)
//        let height = collectionView.frame.size.height / weekcnt
//        return CGSize(width: self.screenWidth/7, height: height)
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
//    }
//
//
//
//
//}
