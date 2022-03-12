//
//  MyMemoryViewController.swift
//  OurMemory
//
//  Created by 이승기 on 2022/02/06.
//

import UIKit
import OurMemoryTask

class MyMemoryViewController: BaseViewController {
    
    var myMemoryCtl:MyMemoryContract?
    @IBOutlet weak var addScheduleBtn: UIButton!
    @IBOutlet weak var calTopContainer: UIView!
    @IBOutlet weak var sharedBtn: UIButton!
    @IBOutlet weak var dateLeftBtn: UIButton!
    @IBOutlet weak var datePickerBtn: UIButton!
    @IBOutlet weak var dateRightBtn: UIButton!
    @IBOutlet weak var updownView: UIView!
    @IBOutlet weak var calCollectionView: UICollectionView!
    @IBOutlet weak var scheduleSv: BaseScrollView!
    @IBOutlet weak var calHeightConstraint: NSLayoutConstraint!
    let selectDayLbl = UILabel()
    
    var orgCalYPOI:CGFloat = 0 // cal org MinY
    var orgCalCenterY:CGFloat = 0 // cal center Y
    var orgCalHeight:CGFloat = 0 // cal org Height
    var orgMoveViewYPOI:CGFloat = 0 // movView org MinY
    var orgMoveViewCenterY:CGFloat = 0 // movView org CenterY
    var orgMoveViewTransLateYPOI:CGFloat = 0 // movView org MaxY
    var contentsArea:CGFloat = mainHeight - 80
    var tabbar:TabbarView!
    let myMemoryCollectionAdapter:MyMemoryCollectionAdapter = MyMemoryCollectionAdapter()
    
    override func getDataContract() -> DataContract? {
        return self.myMemoryCtl
    }
    
    override func prepareViewWithData(data: Any?) {
        if self.getDataContract() == nil {
            
            
            addScheduleBtn.addAction { p1 in
                self.myMemoryCtl?.actionAddSchduleBtn(sender: p1 as! UIButton)
            }
            
            sharedBtn.addAction { p1 in
                self.myMemoryCtl?.actionSelectSharedBtn(sender: p1 as! UIButton)
            }
            
            dateLeftBtn.addAction { p1 in
                //                self.myMemoryCtl.act
            }
            
            datePickerBtn.addAction { p1 in
                //                self.myMemoryCtl
            }
            
            dateRightBtn.addAction { p1 in
                //                self.myMemoryCtl
            }
            
            myMemoryCtl = CtlMaker().createDataControllerWithContract(contract: .eContractMyMemory, view: self, data: data) as? MyMemoryContract
            myMemoryCollectionAdapter.setCollection(collectionView: self.calCollectionView)
            myMemoryCtl?.setCollectionWithAdpater(adapter: myMemoryCollectionAdapter)
            
            self.calCollectionView.registCell(cellIdentifier: MyMemoryCollectionViewCell.className())
            orgCalHeight = self.calCollectionView.frame.height
            orgCalCenterY = self.calCollectionView.center.y
            orgCalYPOI = self.calCollectionView.frame.minY
            let calGs = UITapGestureRecognizer(target: self, action: #selector(closeTabbar(sender:)))
            calGs.numberOfTapsRequired = 1
            self.calCollectionView.addGestureRecognizer(calGs)
            let dragingCalGs = UIPanGestureRecognizer(target: self, action: #selector(wasCalDragged(gestureRecognizer:)))
            dragingCalGs.delegate = self
            self.calCollectionView.addGestureRecognizer(dragingCalGs)
            
            let calTopGs = UITapGestureRecognizer(target: self, action: #selector(closeTabbar(sender:)))
            calTopGs.numberOfTapsRequired = 1
            self.calTopContainer.addGestureRecognizer(calTopGs)
            
            let moveViewGs = UITapGestureRecognizer(target: self, action: #selector(closeTabbar(sender:)))
            moveViewGs.numberOfTapsRequired = 1
            self.updownView.addGestureRecognizer(moveViewGs)
            orgMoveViewTransLateYPOI = self.updownView.frame.minY
            orgMoveViewCenterY = self.updownView.center.y
            orgMoveViewYPOI = self.updownView.frame.minY
            
            let dragingViewGs = UIPanGestureRecognizer(target: self, action: #selector(wasViewDragged(gestureRecognizer:)))
            dragingViewGs.delegate = self
            self.updownView.addGestureRecognizer(dragingViewGs)
        }else {
            if let ctl = self.getDataContract() as? MyMemoryContract {
                ctl.reloadView()
            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.tabbar.updateTabViewState(open: false)
        super.touchesBegan(touches, with: event)
    }
    
    override func showNextVC(vc: NEXTVIEW, data: Any?) {
        switch vc {
        case .NEXTVIEW_ADDSCHEDULE:
            self.navigate(vc, animation: true, data: data, onInitVc: nil)
            break
        case .NEXTViEW_SHAREDLIST:
            break
        default:
            break
        }
    }
    
}

extension MyMemoryViewController: MyMemoryView {
    func setTabbarView(tabView:UIView) {
        if let tabbar = tabView as? TabbarView {
            self.tabbar = tabbar
            self.view.addSubview(tabView)
        }
    }
    
    func updateNotiCnt(items:[UInt:Int]) {
        
    }
    
    @objc func closeTabbar(sender: UITapGestureRecognizer) {
        self.tabbar.updateTabViewState(open: false)
    }
    
    func updateYearMonth(yearMonth:(String,String)) {
        self.datePickerBtn.setTitle("\(yearMonth.0).\(yearMonth.1)", for: .normal)
    }
    
    func updateScheduleDatas(datas:[ScheduleDateDataBinder]?) {
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
                    if let ctl = self.getDataContract() as? MyMemoryContract {
                        ctl.selectScheduleIndex(index: p1)
                    }
                }
            }
        }
    }
}

extension MyMemoryViewController:UIGestureRecognizerDelegate {
    
    @objc func wasCalDragged(gestureRecognizer: UIPanGestureRecognizer) {
        let translation = gestureRecognizer.translation(in: self.view)
        
        if gestureRecognizer.state == UIGestureRecognizer.State.began || gestureRecognizer.state == UIGestureRecognizer.State.changed {
            if(gestureRecognizer.view!.frame.minY <= self.orgCalYPOI) {
                gestureRecognizer.view!.frame.origin.y = self.orgCalYPOI
                self.calHeightConstraint.constant -= translation.y
            }
            else  {
                gestureRecognizer.view!.frame.origin.y = self.orgCalYPOI
                self.calHeightConstraint.constant += translation.y
            }
            if gestureRecognizer.view!.frame.maxY > self.orgMoveViewYPOI{
                
                self.calCollectionView.reloadData()
                self.calCollectionView.collectionViewLayout.invalidateLayout()
            }
            gestureRecognizer.setTranslation(CGPoint(x:0,y:0), in: self.view)
            
        }
        else if gestureRecognizer.state == UIGestureRecognizer.State.ended {
            
            if gestureRecognizer.view!.frame.maxY < self.orgCalCenterY {
                self.calHeightConstraint.constant = 0
            }else if gestureRecognizer.view!.frame.maxY < self.orgMoveViewCenterY||gestureRecognizer.view!.frame.maxY <= self.orgMoveViewYPOI {
                UIView.animate(withDuration: 0.5) {
                    self.calHeightConstraint.constant = self.orgCalHeight
                } completion: { _ in
                    self.updownView.layoutIfNeeded()
                    self.calCollectionView.reloadData()
                    self.calCollectionView.collectionViewLayout.invalidateLayout()
                }
            }
        }
        
        
    }
    
    @objc func wasViewDragged(gestureRecognizer: UIPanGestureRecognizer) {
        let translation = gestureRecognizer.translation(in: self.view)
        
        if gestureRecognizer.state == UIGestureRecognizer.State.began || gestureRecognizer.state == UIGestureRecognizer.State.changed {
            
            if 0 > translation.y {
                self.calHeightConstraint.constant += translation.y
                
            }else if 0 < translation.y {
                self.calHeightConstraint.constant += translation.y
                
            }
            
            if gestureRecognizer.view!.frame.minY <= self.orgCalYPOI{
                gestureRecognizer.view!.frame.origin.y = self.orgCalYPOI
            }
            
            if gestureRecognizer.view!.frame.minY >= self.orgMoveViewYPOI{
                self.calCollectionView.reloadData()
            }
            
            gestureRecognizer.setTranslation(CGPoint(x:0,y:0), in: self.view)
        }else if gestureRecognizer.state == UIGestureRecognizer.State.ended {
            UIView.animate(withDuration: 0.5) {
                if gestureRecognizer.view!.frame.minY < self.orgCalCenterY {
                    self.calHeightConstraint.constant = 0
                }else if gestureRecognizer.view!.frame.minY <= self.orgMoveViewYPOI {
                    self.calHeightConstraint.constant = self.orgCalHeight
                }else if gestureRecognizer.view!.frame.minY < self.orgMoveViewCenterY {
                    self.calHeightConstraint.constant = self.orgCalHeight
                }else if gestureRecognizer.view!.frame.minY < gestureRecognizer.view!.frame.maxY{
                    self.calHeightConstraint.constant = self.contentsArea
                }
            }
        }
        
    }
    
    func checkScrollPoint(ypoint:CGFloat)  {
        
        
        
    }
}
