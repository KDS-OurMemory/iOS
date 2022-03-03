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
    @IBOutlet weak var sharedBtn: UIButton!
    @IBOutlet weak var dateLeftBtn: UIButton!
    @IBOutlet weak var datePickerBtn: UIButton!
    @IBOutlet weak var dateRightBtn: UIButton!
    @IBOutlet weak var updownView: UIView!
    @IBOutlet weak var calCollectionView: UICollectionView!
    @IBOutlet weak var scheduleSv: BaseScrollView!
    let selectDayLbl = UILabel()
    
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
            
            
        }
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
    
    func updateYearMonth(yearMonth:(String,String)) {
        self.datePickerBtn.setTitle("\(yearMonth.0).\(yearMonth.1)", for: .normal)
    }
    
}

extension MyMemoryViewController:UIGestureRecognizerDelegate {
    
//    @objc func wasViewDragged(gestureRecognizer: UIPanGestureRecognizer) {
//        let translation = gestureRecognizer.translation(in: self.view)
//           print(translation.y)
//
////        print(gestureRecognizer.view?.frame.origin.y)
//        if gestureRecognizer.state == UIGestureRecognizer.State.began || gestureRecognizer.state == UIGestureRecognizer.State.changed {
//            if(gestureRecognizer.view!.center.y > self.contentsViewCenterY) {
//                gestureRecognizer.view!.center = CGPoint(x: gestureRecognizer.view!.center.x, y: gestureRecognizer.view!.center.y+translation.y)
//                if (gestureRecognizer.view?.frame.origin.y)! > self.contentsViewCenterY
//                {
//                    self.moveCalHeightConstraints.constant = self.moveCalHeightConstraints.constant + translation.y
//                    UIView.animate(withDuration: 0.2) {
//                        self.calView.reloadData()
//                        self.calView.collectionViewLayout.invalidateLayout()
//                    }
//
//                }
//            }
//            else {
//                gestureRecognizer.view!.center = CGPoint(x:gestureRecognizer.view!.center.x, y:self.contentsViewCenterY+1)
//               }
//
//            gestureRecognizer.setTranslation(CGPoint(x:0,y:0), in: self.view)
//        }else if gestureRecognizer.state == UIGestureRecognizer.State.ended {
//            if (self.contentsviewTop..<self.contentsViewCenterY/1.5).contains(gestureRecognizer.view!.frame.origin.y) {
//                UIView.animate(withDuration: 0.5) {
//                    gestureRecognizer.view?.frame.origin.y = self.contentsviewTop
//                }
//            }else if (self.contentsViewCenterY/1.5..<self.contentsViewCenterY).contains((gestureRecognizer.view?.frame.origin.y)!)  {
//                UIView.animate(withDuration: 0.5) {
//                    gestureRecognizer.view?.frame.origin.y = self.contentsViewCenterY
//                    self.moveCalHeightConstraints.constant = (gestureRecognizer.view?.frame.origin.y)! - self.contentsviewTop
//                    UIView.animate(withDuration: 0.5) {
//                        self.calView.reloadData()
//                        self.calView.collectionViewLayout.invalidateLayout()
//                    }
//                }
//            }else if (self.contentsViewCenterY..<self.contentsViewCenterY*1.5).contains((gestureRecognizer.view?.frame.origin.y)!)  {
//                UIView.animate(withDuration: 0.5) {
//                    self.moveCalHeightConstraints.constant = self.movecalOriginSize
//                    gestureRecognizer.view?.frame.origin.y = self.contentsViewCenterY
//                } completion: { _ in
//                    UIView.animate(withDuration: 0.5) {
//                        self.calView.reloadData()
//                        self.calView.collectionViewLayout.invalidateLayout()
//                    }
//                }
//
//            }
//            else {
//                UIView.animate(withDuration: 0.5) {
//                    gestureRecognizer.view?.frame.origin.y = self.screenHeight
//                    self.moveCalHeightConstraints.constant = (gestureRecognizer.view?.frame.origin.y)! - self.contentsviewTop
//                    UIView.animate(withDuration: 0.5) {
//                        self.calView.reloadData()
//                        self.calView.collectionViewLayout.invalidateLayout()
//                    }
//                }
//            }
//        }
//
//    }

    func checkScrollPoint(ypoint:CGFloat)  {

        

    }
}
