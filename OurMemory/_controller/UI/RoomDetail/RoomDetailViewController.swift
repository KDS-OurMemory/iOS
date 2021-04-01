//
//  RoomDetailViewController.swift
//  OurMemory
//
//  Created by 이승기 on 2021/03/22.
//

import UIKit

class RommDetailDateComponentsModel: NSObject {
    let date = Date();
    let cal = Calendar.current;
    var components:DateComponents!

    override init() {
        self.components = self.cal.dateComponents([.year,.month,.day], from: self.date)
    }
    
    func getCurrentDate() -> DateComponents {
         return self.cal.dateComponents([.year,.month,.day], from: self.date)
    }
    
    func getDayCntOfMonth() -> Int {
        if let dayCnt = self.cal.ordinality(of: .day, in: .month, for: date) {
            return dayCnt
        }
        
        return 0
    }
    
    func getToday() -> Int {
        if let day = self.getCurrentDate().day {
            return day
        }
        
        return 0
    }
    
}

class RoomDetailCtl: NSObject {
    let roomDetailModel:RommDetailDateComponentsModel = RommDetailDateComponentsModel()
    
    func getDayCntOfMonth() -> Int {
        return self.roomDetailModel.getDayCntOfMonth()
    }
    
    func getToday() -> Int {
        return self.roomDetailModel.getToday()
    }
}

class RoomDetailViewController: BaseViewController {

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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpLayout()
        setUpDefine()
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
