//
//  AddRoomViewController.swift
//  OurMemory
//
//  Created by 이승기 on 2022/02/23.
//

import UIKit

class AddRoomViewController: BaseViewController {

    @IBOutlet weak var topViewContainer: UIView!
    
    @IBOutlet weak var addUsersCollectionView: UICollectionView!
    
    
    @IBOutlet weak var selectedUserSvContainer: UIView!
    @IBOutlet weak var selectedUsersSv: BaseScrollView!
    @IBOutlet weak var selectedUserSvContainerHeight: NSLayoutConstraint!
    
    var addRoomCtl:AddRoomContract?
    
    var addRoomAdapter:AddRoomCollectionAdapter = AddRoomCollectionAdapter()
    let topView:TopView = TopView()
    
    override func getDataContract() -> DataContract? {
        self.addRoomCtl
    }
    
    override func prepareViewWithData(data: Any?) {
        if self.getDataContract() == nil {
            addRoomCtl = CtlMaker().createDataControllerWithContract(contract: .eContractAddRoom, view: self, data: data) as? AddRoomContract
            addRoomCtl?.setCollectionWithAdpater(adapter: addRoomAdapter)
            addRoomAdapter.setCollection(collectionView: addUsersCollectionView)
            
            addUsersCollectionView.registCell(cellIdentifier: NoItemCollectionViewCell.className())
            addUsersCollectionView.registCell(cellIdentifier: SearchCollectionViewCell.className())
            addUsersCollectionView.registCell(cellIdentifier: CheckFriendsCollectionViewCell.className())
        }
        
        topViewContainer.addSubview(topView)
        topView.setTitle(title: "일정 공유방 생성")
        
        topView.setLeftBtn(btnTitle: nil, btnImage: UIImage(systemName: "xmark")) {
            self.showNextVC(vc: .NEXTVIEW_POP, data: nil)
        }
        
        topView.setRightBtn(btnTitle: "확인", btnImage: nil) {
            if let ctl = self.getDataContract() as? AddRoomContract {
                ctl.actionConfirmBtn()
            }
        }
        self.updateSelectedUserCnt(cnt: 0)
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
}


extension AddRoomViewController: AddRoomView {
    
    func updateSelectedUserDatas(datas:[FriendsDataBinder]) {
        let itemHorPadding = 10.0
        selectedUsersSv.resetSubViews()
        selectedUserSvContainerHeight.constant = (datas.count == 0 ? 0:60)
        selectedUsersSv.isHidden = (datas.count == 0)
        for data in datas {
            let item:SelectedUserView = SelectedUserView()
            item.setData(data: data)
            selectedUsersSv.addHorScrollSubView(subView: item, viewSize: item.frame.size, horPadding: itemHorPadding)
            item.setCloseBtnBlock {
                if let ctl = self.getDataContract() as? AddRoomContract {
                    ctl.removeSelectedUserItemAtIndex(idx: self.selectedUsersSv.subviews.firstIndex(of: item)!)
                }
            }
        }
    }
    
    func updateSelectedUserCnt(cnt:Int) {
        topView.setRightBtnChangeState(state: (cnt != 0))
        topView.setRightBtnTitle(title: (cnt != 0 ?  "\(cnt) ":"") + "확인")
    }
}
