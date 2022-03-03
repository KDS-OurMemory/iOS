//
//  MyProfileViewController.swift
//  OurMemory
//
//  Created by 이승기 on 2022/02/05.
//

import UIKit

class MyProfileViewController: BaseViewController {
    
    var myProfileCtl:MyProfileContract?
    @IBOutlet weak var topViewContainer: UIView!
    @IBOutlet weak var itemContainer: UIView!
    let topView:TopView = TopView()
    var tabbar:TabbarView!
    @IBOutlet weak var profileItemSv: BaseScrollView!
    @IBOutlet weak var logOutBtn: UIButton!
    
    let profileImageView:UIImageView = UIImageView()
    let profileImageBtn:UIButton = UIButton()
    let idView:KeyValueView = KeyValueView()
    let nickNameView:KeyValueView = KeyValueView()
    let loginSnsTypeView:KeyValueView = KeyValueView()
    let birthdayView:KeyValueView = KeyValueView()
    let birthdayIsOnOffView:KeySwitchView = KeySwitchView()
    let pushIsOnOffView:KeySwitchView = KeySwitchView()
    let withdrawalView:SelectView = SelectView()
    let imagePicker:UIImagePickerController = UIImagePickerController()
    let imagePickerAdapter:MyProfilePickerControllerAdapter = MyProfilePickerControllerAdapter()
    
    
    
    override func getDataContract() -> DataContract? {
        return self.myProfileCtl
    }
    
    override func prepareViewWithData(data: Any?) {
        if self.getDataContract() == nil {
            
            topView.setTitle(title: "마이페이지")
            topViewContainer.addSubview(topView)
            topView.setRightBtn(btnTitle: "수정", btnImage: nil) {
                if let ctl = self.getDataContract() as? MyProfileContract {
                    //수정화면으로 이동
                }
            }
            
            let imgView = UIView(frame: CGRect(x: 0, y: 0, width: mainWidth, height: 100))
            imgView.addSubview(profileImageView)
            imgView.addSubview(profileImageBtn)
            profileImageView.frame = CGRect(x: mainWidth/3, y: 0, width: mainWidth/3, height: 100)
            profileImageBtn.frame = CGRect(x: profileImageView.frame.minX, y: 0, width: profileImageView.frame.width, height: profileImageView.frame.height)
            
            profileImageBtn.addAction { p1 in
                if let ctl = self.getDataContract() as? MyProfileContract {
                    ctl.actionProfileImage(imageSize: self.profileImageView.frame.size)
                }
            }
            
            profileItemSv.addVerScrollSubView(subView: imgView, viewSize: imgView.frame.size, verPadding: 15)
            
            profileItemSv.addVerScrollSubView(subView: idView, viewSize: idView.frame.size, verPadding: 45)
            profileItemSv.addVerScrollSubView(subView: nickNameView, viewSize: nickNameView.frame.size, verPadding: 5)
            profileItemSv.addVerScrollSubView(subView: loginSnsTypeView, viewSize: birthdayView.frame.size, verPadding: 5)
            profileItemSv.addVerScrollSubView(subView: birthdayView, viewSize: birthdayView.frame.size, verPadding: 5)
            let line1View = UIView(frame: CGRect(x: 0, y: 0, width: mainWidth, height: 2))
            profileItemSv.addVerScrollSubView(subView: line1View, viewSize: line1View.frame.size, verPadding: 5)
            line1View.backgroundColor = .gray
            profileItemSv.addVerScrollSubView(subView: pushIsOnOffView, viewSize: pushIsOnOffView.frame.size, verPadding: 5)
            let line2View = UIView(frame: CGRect(x: 0, y: 0, width: mainWidth, height: 2))
            profileItemSv.addVerScrollSubView(subView: line2View, viewSize: line2View.frame.size, verPadding: 5)
            line2View.backgroundColor = .gray
            profileItemSv.addVerScrollSubView(subView: withdrawalView, viewSize: withdrawalView.frame.size, verPadding: 5)
            withdrawalView.setTitleWithImg(title: "회원 탈퇴", img: UIImage(systemName: "chevron.right"))
            
            myProfileCtl = CtlMaker().createDataControllerWithContract(contract: .eContractMyProFile, view: self, data: data) as? MyProfileContract
            self.myProfileCtl?.setPHPickerControllerAdapter(adapter: imagePickerAdapter)
            self.imagePickerAdapter.setContext(context: self)
            
        }
        
    }
    
}

extension MyProfileViewController: MyProfileView {
    func setTabbarView(tabView:UIView) {
        if let tabbar = tabView as? TabbarView {
            self.tabbar = tabbar
            self.view.addSubview(tabView)
        }
    }
    
    func updateNotiCnt(items:[UInt:Int]) {
        
    }
    
    func updateProfileImage(profileImg:UIImage) {
        profileImageView.image = profileImg
    }
    
    func updateProfileData(profileData:UserDataBinder) {
        
        if let profileImg = profileData.getProfileImage() {
            profileImageView.image = profileImg
        }else {
            profileImageView.image = .init(systemName: "person.crop.circle.fill.badge.plus")
        }
        
        idView.setKeyAndValueTitle(key: "아이디", value: profileData.getUserId())
        nickNameView.setKeyAndValueTitle(key: "이름(닉네임)", value: profileData.getName())
        loginSnsTypeView.setKeyAndValueTitle(key: "로그인 유형", value: profileData.getSnsType())
        birthdayView.setKeyAndValueTitle(key: "생일", value: "\(profileData.getBirthday()!)/\((profileData.getIsSolar()! ? "양력":"음력"))/\((profileData.getBirthdayOpen()! ? "공개":"비공개"))")
        
        pushIsOnOffView.setKeyAndValueTitle(key: "푸쉬 알림")
        
        pushIsOnOffView.setSwitchState(state: profileData.getIsPush())
        pushIsOnOffView.setSwitchBlock { p1 in
            if let ctl = self.getDataContract() as? MyProfileContract {
                ctl.actionSwitchPush(state: p1)
            }
        }
        
        withdrawalView.selectBlock {
            // 회원 탈퇴
        }
        
        logOutBtn.addAction { p1 in
            if let ctl = self.getDataContract() as? MyProfileContract {
                ctl.actionLogoutBtn()
            }
        }
        
        
    }
}

