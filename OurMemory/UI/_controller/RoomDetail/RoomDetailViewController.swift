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

    @IBOutlet weak var calLbl: UILabel!
    @IBOutlet weak var topViewContainer: UIView!
    @IBOutlet weak var calLeftBtn: UIButton!
    @IBOutlet weak var calRightBtn: UIButton!
    let topView:TopView = TopView()
    
    var screenWidth:CGFloat!
    var screenHeight:CGFloat!

    var contentScreenHeight:CGFloat!
    var contentsViewCenterY:CGFloat!

    var contentsviewTop:CGFloat!
    var movecalOriginSize:CGFloat!

    var roomDetailCtl:RoomDetailContract?

    override func prepareViewWithData(data: Any?) {
        
        self.moveCal.registCell(cellIdentifier: RoomDetailCalCollectionViewCell.className())
        
        topView.frame = CGRect(x: 0, y: 0, width: self.topViewContainer.frame.width, height: self.topViewContainer.frame.height)
        self.topViewContainer.addSubview(topView)
        
        topView.setLeftBtn(btnTitle: nil, btnImage: UIImage(systemName:"chevron.backward")) {
            self.showNextVC(vc: .NEXTVIEW_POP, data: nil)
        }
        topView.setRightBtn(btnTitle: nil, btnImage: UIImage(systemName: "line.3.horizontal")) {
            
        }
        
        roomDetailCtl = CtlMaker().createDataControllerWithContract(contract: .eContractRoomDetail, view: self, data: data) as? RoomDetailContract
        
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

        let calGesture = UIPanGestureRecognizer(target: self, action: #selector(self.wasCalDragged(gestureRecognizer:)))
        self.moveCal.addGestureRecognizer(calGesture)

        self.movecalOriginSize = self.contentsViewCenterY - self.contentsviewTop
        self.moveCalHeightConstraints.constant = self.movecalOriginSize
        calGesture.delegate = self

        let viewGesture = UIPanGestureRecognizer(target: self, action: #selector(self.wasViewDragged(gestureRecognizer:)))
        upandDownView.addGestureRecognizer(viewGesture)
        upandDownView.isUserInteractionEnabled = true
        viewGesture.delegate = self
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

extension RoomDetailViewController:RoomDetailView {
    func updateRoomData(data:RoomDataBinder) {
        topView.setTitle(title: data.getName())
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
